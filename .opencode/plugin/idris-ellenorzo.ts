import type { Plugin } from "@opencode-ai/plugin"

// ═══════════════════════════════════════════════════════════════
// IDRIS ELLENŐRZŐ PLUGIN — a kritikus szabályok mechanikus
// kikényszerítése minden .idr fájl szerkesztése után.
//
// A projekt lényege: az Idris kód maga a kutatás (leírás +
// bizonyítás + teszt + futtatás). Ezért a szabályszegést azonnal
// jelezni kell, nem a következő fordításnál.
//
// A plugin a projekt gyökerében lévő ellenorzes.sh szkriptet
// futtatja, amely a következőket ellenőrzi:
//   1. rövidítés-alias definíciók tiltása (MH, MS, DG, ...)
//   2. kisbetűs konstansnév bizonyítástípusban (Idris 0.8.0 csapda)
// ═══════════════════════════════════════════════════════════════

export default (async ({ directory, $ }) => {
  return {
    "tool.execute.after": async (input, output) => {
      try {
        const szerkesztettFajlUtvonal =
          typeof output?.metadata?.filePath === "string"
            ? output.metadata.filePath
            : typeof (output as any)?.filePath === "string"
              ? (output as any).filePath
              : ""

        // /tmp TILOS (AGENTS.md 1a): barmely bash parancs, ami /tmp-be ir
        const parancs =
          typeof (input?.args as any)?.command === "string"
            ? (input?.args as any).command
            : ""
        if (/\/tmp\/|>\s*\/tmp\//.test(parancs) && !/rm\s+-\w*\s*\/tmp/.test(parancs)) {
          const figyelmeztetesTmp =
            "\n\n⚠️ /tmp TILOS (AGENTS.md 1a): az újraindítás törli a munka nyomát. " +
            "Ideiglenes fájl: osveny_index/tanulsagok/ vagy " +
            "/var/folders/cw/4jhpxnwn47d7y4jyg2zgvpx80000gn/T/opencode"
          if (typeof output.output === "string") {
            output.output += figyelmeztetesTmp
          } else {
            ;(output as any).output = figyelmeztetesTmp
          }
        }

        const idrisFajltErinthet =
          szerkesztettFajlUtvonal.endsWith(".idr") ||
          JSON.stringify(input?.args ?? {}).includes(".idr")

        if (!idrisFajltErinthet) return

        const futtatas = await $`bash ellenorzes.sh`.cwd(directory).noThrow()
        const kimenet = futtatas.stdout?.toString() ?? ""

        const szabalySzegesVan = kimenet.includes("SZABÁLYSZEGÉS")
        if (szabalySzegesVan) {
          const figyelmeztetes =
            "\n\n⚠️ ELLENŐRZÉS: Idris szabályszegés történt!\n" +
            kimenet +
            "\nJavítsd a jelzett sorokat. A szabályok oka: rövidítések " +
            "tiltása (a kód önmagában olvasható legyen), és a kisbetűs " +
            "konstansnév bizonyítástípusban implicit kötést okoz (Idris 0.8.0)."
          if (typeof output.output === "string") {
            output.output += figyelmeztetes
          } else {
            ;(output as any).output = figyelmeztetes
          }
        }
      } catch {
        // Az ellenőrzés hibája sosem akadályozza a szerkesztést.
      }
    },
  }
}) satisfies Plugin
