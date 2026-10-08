-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.weyl_friedrichs_bounded
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.ChapterH5
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.YangMillsFriedrichsLimit.weyl_friedrichs_bounded [CompleteSpace F] {D : Submodule ℂ F} {n m : ℕ}
    {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hdense : Dense (D : Set F))
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a)))
    (C : ℝ) (hbd : ∀ x : D, ‖weylOp pi Bf x‖ ≤ C * ‖(x : F)‖) (v : F) :
    ∃ A : F →L[ℂ] F,
      (∀ x : D, A (x : F) = weylOp pi Bf x) ∧
      IsPositiveSelfAdjointExtension (weylOp pi Bf) (topRestrict A) ∧
      (Dense ((⨆ k : ℕ, krylovSpan A.toLinearMap v k : Submodule ℂ F) : Set F) →
        ∀ u : F, Filter.Tendsto (fun k : ℕ => sirkCompression A v k u)
          Filter.atTop (nhds (A u))) := by sorry
