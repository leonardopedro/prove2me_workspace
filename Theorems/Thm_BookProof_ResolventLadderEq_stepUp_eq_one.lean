-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.stepUp_eq_one
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
import Definitions.Def_ChapterVonNeumannCore


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum
open BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.ResolventLadderEq.stepUp_eq_one {c δ t : ℝ} (hδ : 0 < δ) (h : c ≤ t) : stepUp c δ t = 1 := by sorry
