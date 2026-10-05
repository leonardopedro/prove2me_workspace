-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.normSq_sq_le_rayleigh_mul
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.RitzMinMax
open BookProof.ResolventLadder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadder.normSq_sq_le_rayleigh_mul {R : F →L[ℂ] F} (hsa : IsSelfAdjoint R)
    (hpos : ∀ x : F, 0 ≤ (inner ℂ x (R x) : ℂ).re) (x : F) :
    ‖R x‖ ^ 4 ≤ rayleighVal R x * rayleighVal R (R x) := by sorry
