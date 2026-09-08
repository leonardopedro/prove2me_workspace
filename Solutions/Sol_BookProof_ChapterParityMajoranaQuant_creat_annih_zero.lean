-- Generated from ChapterParityMajoranaQuant.lean — solution of BookProof.ChapterParityMajoranaQuant.creat_annih_zero
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
import Theorems.Thm_BookProof_ChapterParityMajoranaQuant_iJ_sq
open BookProof.ChapterParityMajoranaQuant











open Matrix
open scoped ComplexConjugate


variable {m : ℕ}




variable (J : Matrix (Fin m) (Fin m) ℂ)

set_option maxHeartbeats 1000000 in
theorem solution (hJ2 : J * J = -1) : creatProj J * annihProj J = 0 := by

  unfold annihProj creatProj
  rw [smul_mul_smul_comm]
  have hK := iJ_sq J hJ2
  set K := iJ J
  have h2 : (1 - K) * (1 + K) = 1 - K * K := by noncomm_ring
  rw [h2, hK]; simp
