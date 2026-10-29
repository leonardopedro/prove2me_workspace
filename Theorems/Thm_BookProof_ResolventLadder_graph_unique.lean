-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.graph_unique
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterVonNeumannCore


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.ResolventLadder.graph_unique (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {y z z' : F}
    (h : (y, z) ∈ T) (h' : (y, z') ∈ T) : z = z' := by sorry
