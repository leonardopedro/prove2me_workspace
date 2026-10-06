-- Generated from ChapterCPTHamiltonian.lean — theorem BookProof.ChapterCPTHamiltonian.diracHamOp_sq
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterCPTHamiltonian


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterCPTHamiltonian.diracHamOp_sq (k : Fin 3 → ℝ) (m1 m2 : ℝ) :
    diracHamOp k m1 m2 * diracHamOp k m1 m2
      = (-((∑ j : Fin 3, (k j : ℂ) ^ 2) + (m1 : ℂ) ^ 2 + (m2 : ℂ) ^ 2))
          • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
