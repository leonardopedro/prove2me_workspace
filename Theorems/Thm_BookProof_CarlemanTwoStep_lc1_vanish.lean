-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.lc1_vanish
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep



open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanTwoStep.lc1_vanish (i : Fin d) (a : Fin d →₀ ℕ) (h : a i < 1) : lc1 a i = 0 := by sorry
