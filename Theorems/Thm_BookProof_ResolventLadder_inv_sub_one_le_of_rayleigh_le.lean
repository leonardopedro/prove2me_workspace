-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.inv_sub_one_le_of_rayleigh_le
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


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.ResolventLadder.inv_sub_one_le_of_rayleigh_le (hT : IsNonnegSelfAdjoint T) {y z : F}
    (hyz : (y, z) ∈ T) (hy : ‖y‖ = 1) {c : ℝ} (hc : 0 < c)
    (hle : rayleighVal (res hT) y ≤ c) : 1 / c - 1 ≤ (inner ℂ y z : ℂ).re := by sorry
