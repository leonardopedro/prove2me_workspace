-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.normSq_sq_le_rayleigh_graph
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
import Definitions.Def_ChapterSirkRitzPerturbation
import Definitions.Def_ChapterVonNeumannCore
open BookProof.RitzMinMax


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.ResolventLadder.normSq_sq_le_rayleigh_graph (hT : IsNonnegSelfAdjoint T) {y z : F} (hyz : (y, z) ∈ T) :
    ‖y‖ ^ 4 ≤ (‖y‖ ^ 2 + (inner ℂ y z : ℂ).re) * rayleighVal (res hT) y := by sorry
