-- Generated from ChapterTruncationGapLift.lean — theorem BookProof.TruncationGapLift.tailSpan_le_finiteModeDomain
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFockGapChain
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin
open BookProof.TruncationGapLift

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.BandEnclosure
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain


theorem BookProof.TruncationGapLift.tailSpan_le_finiteModeDomain (b : HilbertBasis ℕ ℂ F) (m : ℕ) :
    tailSpan b m ≤ finiteModeDomain b := by sorry
