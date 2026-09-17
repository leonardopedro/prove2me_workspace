-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.weyl_hashimoto_selects_friedrichs
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_hashimoto_selects
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm_nonneg
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_symmetricOn
open BookProof.FriedrichsExtension




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) {n m : ℕ}
    {pi : Fin n → finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    {Bf : Fin m → finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    (hpi : ∀ i, SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp (Bf a)))
    {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (R : F →L[ℂ] F),
      IsPositiveSelfAdjointExtension (weylOp pi Bf) A ∧ IsShiftInvert A γ R ∧
        IsSelfAdjoint R ∧
        (∀ u : F, Tendsto (fun k : ℕ => galerkinCompression R b k u) atTop (nhds (R u))) ∧
        (∀ (Dom' : Submodule ℂ F) (A' : Dom' →ₗ[ℂ] F), IsShiftInvert A' γ R → Dom' = Dom) := by

  obtain ⟨Dom, A, R, hA, hR, -, hsa, hstrong, -, huniq⟩ :=
    friedrichs_hashimoto_selects b (weylOp pi Bf) (weylOpDom_symmetricOn hpi hB)
      (weylOpDom_quadForm_nonneg hpi hB) hγ
  exact ⟨Dom, A, R, hA, hR, hsa, hstrong, fun Dom' A' hA' => (huniq Dom' A' hA').1⟩
