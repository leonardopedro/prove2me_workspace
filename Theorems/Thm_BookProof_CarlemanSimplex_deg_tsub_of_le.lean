-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.deg_tsub_of_le
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.deg_tsub_of_le {P a : Fin d →₀ ℕ} (h : P ≤ a) : deg (a - P) + deg P = deg a := by sorry
