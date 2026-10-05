-- Generated from ChapterSchurGershgorinGap.lean — theorem BookProof.SchurGershgorin.quadForm_ge_of_gershgorin
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTruncationGapLift
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFockGapChain
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin
open BookProof.SchurGershgorin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain


theorem BookProof.SchurGershgorin.quadForm_ge_of_gershgorin (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H) {mu : ℝ} (d r : ℕ → ℝ)
    (hdiag : ∀ i, d i ≤ (entry b H i i).re)
    (hrow : ∀ i, ∀ S : Finset ℕ, i ∉ S → ∑ j ∈ S, ‖entry b H i j‖ ≤ r i)
    (hgap : ∀ i, mu ≤ d i - r i) (v : finiteModeDomain b) :
    mu * ‖(v : F)‖ ^ 2 ≤ quadForm H v := by sorry
