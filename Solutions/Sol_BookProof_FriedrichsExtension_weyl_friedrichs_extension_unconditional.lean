-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.weyl_friedrichs_extension_unconditional
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} {n m : ℕ}
    {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hdense : Dense (D : Set F))
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F),
      IsPositiveSelfAdjointExtension (weylOp pi Bf) A :=
  friedrichs_extension_exists
      ⟨D, weylOp pi Bf, weylOpDom_symmetricOn hpi hB, weylOpDom_quadForm_nonneg hpi hB⟩ hdense
