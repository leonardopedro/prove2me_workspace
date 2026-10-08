-- Generated from ChapterSymmetryEntropy.lean — theorem BookProof.SymmetryEntropy.entropy_pointMass
import Definitions.Def_ChapterMarkovEntropy
import Definitions.Def_ChapterReconstruct
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
import Definitions.Def_ChapterIrreversible
open BookProof.SymmetryEntropy



open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}


theorem BookProof.SymmetryEntropy.entropy_pointMass (a : Fin n) :
    entropy (fun k => if k = a then (1 : ℝ) else 0) = 0 := by sorry
