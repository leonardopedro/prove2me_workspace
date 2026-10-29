-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.rayleighVal_neg
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

variable {T : Submodule ℂ (F × F)}

theorem BookProof.ResolventLadder.rayleighVal_neg (R : F →L[ℂ] F) (x : F) : rayleighVal (-R) x = -rayleighVal R x := by sorry
