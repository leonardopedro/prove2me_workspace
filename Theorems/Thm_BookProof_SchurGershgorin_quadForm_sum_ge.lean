-- Generated from ChapterSchurGershgorinGap.lean — theorem BookProof.SchurGershgorin.quadForm_sum_ge
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


noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.SchurGershgorin.quadForm_sum_ge (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (hsym : SymmetricOn _ H) (S : Finset ℕ) (c : ℕ → ℂ) (d r : ℕ → ℝ)
    (hdiag : ∀ i ∈ S, d i ≤ (entry b H i i).re)
    (hrow : ∀ i ∈ S, ∑ j ∈ S.erase i, ‖entry b H i j‖ ≤ r i) :
    ∑ i ∈ S, (d i - r i) * ‖c i‖ ^ 2 ≤ quadForm H (∑ i ∈ S, c i • bvec b i) := by sorry
