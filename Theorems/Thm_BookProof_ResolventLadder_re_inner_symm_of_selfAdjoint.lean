-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.re_inner_symm_of_selfAdjoint
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

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadder.re_inner_symm_of_selfAdjoint {R : F →L[ℂ] F} (hsa : IsSelfAdjoint R) (x y : F) :
    (inner ℂ x (R y) : ℂ).re = (inner ℂ y (R x) : ℂ).re := by sorry
