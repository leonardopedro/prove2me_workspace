-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.one_le_add_mul_rayleigh_of_unit
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterStoneResolvent
open BookProof.RitzMinMax
open BookProof.ResolventLadder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadder.one_le_add_mul_rayleigh_of_unit (hT : IsNonnegSelfAdjoint T) {y z : F}
    (hyz : (y, z) ∈ T) (hy : ‖y‖ = 1) :
    1 ≤ (1 + (inner ℂ y z : ℂ).re) * rayleighVal (res hT) y := by sorry
