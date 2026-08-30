module Docs.GenTodo

import System.IO
import System.Process
import Data.List
import Data.String
import Data.Vect

-- | Generate a TODO markdown file from source files.
main : IO ()
main = do
  -- Define source directories to search
  let dirs = ["src", "dev2/deepseekPage", "agents"]
      exts = [".idr", ".py", ".sh", ".md"]  -- we can filter by extension if needed
  -- Use find to get all files with those extensions
  let findCmd = "find " ++ unwords (map (\d => " -path " ++ show d ++ " -type f") dirs) ++ " -type f \\( -name \"*.idr\" -o -name \"*.py\" -o -name \"*.sh\" -o -name \"*.md\" \\)"
  -- Actually, simpler: use find with -o
  let findCmd' = "find " ++ unwords dirs ++ " -type f \\( -name \"*.idr\" -o -name \"*.py\" -o -name \"*.sh\" -o -name \"*.md\" \\)"
  (exitCode, out, err) <- readProcessWithExitCode "bash" ["-c", findCmd'] ""
  case exitCode of
    ExitSuccess => 
      let files = lines out
          -- For each file, grep for TODO lines
          todos = concatMap (\f => 
                            let (_, grepOut, _) = 
                                  readProcessWithExitCode "grep" ["-n", "-i", "TODO", f] ""
                            in 
                              map (\line => 
                                    let parts = split (== ':') line
                                    -- parts: [file, lineNumber, rest...]
                                    case parts of
                                      fileNum :: lineNum :: rest => 
                                        let msg = unlines (map (\p => p ++ ":") rest)  -- Actually we want the rest after second colon
                                        -- Better: join after second colon
                                        let msg = 
                                              case rest of
                                                [] => ""
                                                r => 
                                                  let first = head r
                                                      restTail = tail r
                                                  in  if null restTail then first else 
                                                      foldl (\acc x => acc ++ ":" ++ x) first restTail
                                          in (fileNum, lineNum, msg)
                                      _ => ("", "", "")
                                  ) (lines grepOut)
                          ) files
          -- Build markdown
          md = 
            "# Generated TODO List\n\n" ++
            "Generated from source files. Do not edit manually.\n\n" ++
            concatMap (\(file, line, msg) => 
                        "- [" ++ file ++ ":" ++ line ++ "] " ++ msg ++ "\n"
                      ) todos
      in 
        writeFile "docs/TODO.md" md
    ExitFailure _ => 
      putStrLn ("Error finding files: " ++ err)