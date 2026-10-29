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
import Definitions.Def_ChapterSirkRitzPerturbation
import Definitions.Def_ChapterVonNeumannCore
open BookProof.RitzMinMax


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.ResolventLadder.normSq_sq_le_rayleigh_mul {R : F →L[ℂ] F} (hsa : IsSelfAdjoint R)
    (hpos : ∀ x : F, 0 ≤ (inner ℂ x (R x) : ℂ).re) (x : F) :
    ‖R x‖ ^ 4 ≤ rayleighVal R x * rayleighVal R (R x) := by sorry
