-- Generated from ChapterSchurGershgorinGap.lean — theorem BookProof.SchurGershgorin.exists_repr_of_mem_span_image
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterTruncationGapLift
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFockGapChain
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
open BookProof.SchurGershgorin


noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.SchurGershgorin.exists_repr_of_mem_span_image (b : HilbertBasis ℕ ℂ F) (T : Set ℕ) {v : F}
    (hv : v ∈ Submodule.span ℂ (b '' T)) :
    ∃ (S : Finset ℕ) (c : ℕ → ℂ), (↑S : Set ℕ) ⊆ T ∧ v = ∑ i ∈ S, c i • b i := by sorry
