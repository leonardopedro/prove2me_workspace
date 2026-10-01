-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.weyl_hashimoto_selects_friedrichs
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]
variable [CompleteSpace F]
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

Dom, A, R, hA, hR, hnorm, hsa, hstrong, hres, huniq⟩

theorem BookProof.FriedrichsExtension.weyl_hashimoto_selects_friedrichs (b : HilbertBasis ℕ ℂ F) {n m : ℕ}
    {pi : Fin n → finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    {Bf : Fin m → finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    (hpi : ∀ i, SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp (Bf a)))
    {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (R : F →L[ℂ] F),
      IsPositiveSelfAdjointExtension (weylOp pi Bf) A ∧ IsShiftInvert A γ R ∧
        IsSelfAdjoint R ∧
        (∀ u : F, Tendsto (fun k : ℕ => galerkinCompression R b k u) atTop (nhds (R u))) ∧
        (∀ (Dom' : Submodule ℂ F) (A' : Dom := by sorry
