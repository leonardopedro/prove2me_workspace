-- Generated from ChapterQedFockGapChain.lean — theorem BookProof.QedFockGapChain.diagOnePart_quadForm_basis
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterFockDiagonalGapChain
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterQedFockGapChain
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin
open BookProof.QedFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FarisLavine
open BookProof.HermiteGalerkin BookProof.HermiteCore
open BookProof.FockDiagonalGapChain BookProof.YangMillsFriedrichs
open MeasureTheory



theorem BookProof.QedFockGapChain.diagOnePart_quadForm_basis (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (k : ℕ) :
    quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) (modeBasis b k) = w k := by sorry
