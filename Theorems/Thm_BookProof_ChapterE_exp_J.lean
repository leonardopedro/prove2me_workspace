-- Generated from ChapterE.lean — theorem BookProof.ChapterE.exp_J
import Mathlib
import Definitions.Def_ChapterE
open BookProof.ChapterE


open scoped Matrix BigOperators
open Filter
open scoped Topology

theorem BookProof.ChapterE.exp_J (t : ℝ) :
    NormedSpace.exp (t • J) = !![Real.cos t, -Real.sin t; Real.sin t, Real.cos t] := by sorry
