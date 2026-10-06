-- Generated from ChapterCPTHamiltonian.lean — theorem BookProof.ChapterCPTHamiltonian.kinSum_sq
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterCPTHamiltonian.kinSum_sq (k : Fin 3 → ℝ) :
    (∑ j : Fin 3, (k j : ℂ) • Kin j) * (∑ j : Fin 3, (k j : ℂ) • Kin j)
      = (∑ j : Fin 3, (k j : ℂ) ^ 2) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
