-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.upsilon_recon
import Mathlib
import Definitions.Def_ChapterA3h
import Theorems.Thm_BookProof_ChapterA3_pauli_expand
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (ν : Fin 4) :
    Tᴴ * pauliσ ν * T = ∑ μ, UpsilonC T μ ν • pauliσ μ := by

  convert pauli_expand ( Tᴴ * pauliσ ν * T ) using 1
  simp only [UpsilonC, Matrix.of_apply]
