-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.smStruct_jacobi
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmBrstGhost_sumStruct_jacobi
import Theorems.Thm_BookProof_SmBrstGhost_su2Struct_jacobi
import Theorems.Thm_BookProof_SmBrstGhost_u1Struct_jacobi
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) (a b c h : Fin 12) :
    ∑ e, (smStruct f3 a b e * smStruct f3 e c h + smStruct f3 b c e * smStruct f3 e a h
      + smStruct f3 c a e * smStruct f3 e b h) = 0 := by

  have hsum := sumStruct_jacobi (f1 := f3) (f2 := sumStruct su2Struct u1Struct) h3
    (sumStruct_jacobi su2Struct_jacobi u1Struct_jacobi)
    (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c) (smIdxEquiv h)
  rw [← Equiv.sum_comp smIdxEquiv] at hsum
  simpa [smStruct] using hsum
