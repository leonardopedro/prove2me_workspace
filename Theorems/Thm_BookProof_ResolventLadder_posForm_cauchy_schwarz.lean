-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.posForm_cauchy_schwarz
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
open BookProof.ResolventLadder


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.ResolventLadder.posForm_cauchy_schwarz {R : F →L[ℂ] F} (hsa : IsSelfAdjoint R)
    (hpos : ∀ x : F, 0 ≤ (inner ℂ x (R x) : ℂ).re) (x y : F) :
    ((inner ℂ x (R y) : ℂ).re) ^ 2 ≤ (inner ℂ x (R x) : ℂ).re * (inner ℂ y (R y) : ℂ).re := by sorry
