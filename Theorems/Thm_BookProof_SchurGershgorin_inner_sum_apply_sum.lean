-- Generated from ChapterSchurGershgorinGap.lean — theorem BookProof.SchurGershgorin.inner_sum_apply_sum
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
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin
open BookProof.SchurGershgorin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain


theorem BookProof.SchurGershgorin.inner_sum_apply_sum (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (S T : Finset ℕ) (c e : ℕ → ℂ) :
    (inner ℂ (∑ i ∈ S, c i • b i) (H (∑ j ∈ T, e j • bvec b j)) : ℂ)
      = ∑ i ∈ S, ∑ j ∈ T, (starRingEnd ℂ) (c i) * e j * entry b H i j := by sorry
