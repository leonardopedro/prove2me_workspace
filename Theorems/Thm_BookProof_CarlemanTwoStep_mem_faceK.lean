-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.mem_faceK
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterHermiteCarlemanEsa
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep



open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanTwoStep.mem_faceK {d N : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ faceK d N i k ↔ (∀ j, a j ≤ N) ∧ N < a i + k := by sorry
