-- Generated from ChapterElectroweakFieldStrength.lean — solution of BookProof.ChapterElectroweakFieldStrength.abelian_fieldStrength
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
import Theorems.Thm_BookProof_ChapterElectroweakFieldStrength_linear_trace
open BookProof.ChapterElectroweakFieldStrength



open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

set_option maxHeartbeats 1000000 in
theorem solution (g G : ℂ) (hg : g ≠ 0) :
    proj g (abelianFmat g G) 2 = G := by

  rw [proj, abelianFmat]
  have h : ((G • ((1 / 2 : ℂ) • pauliV 2)) * pauliV 2).trace = G := by
    have := linear_trace (fun m => if m = 2 then G else 0) 2
    simpa [Fin.sum_univ_three, connection] using this
  rw [Matrix.smul_mul, Matrix.trace_smul, h, smul_eq_mul]
  field_simp
  rw [Complex.I_sq]
  ring
