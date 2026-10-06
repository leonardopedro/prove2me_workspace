-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.annih_occ_sign
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : (annih (1 : Fin 2) (occ {0, 1})) {0} = -1 := by

  have h1 : ({1, 0} : Finset (Fin 2)) = {0, 1} := by decide
  have h2 : (({0} : Finset (Fin 2)).filter (fun j => j = (0 : Fin 2))).card = 1 := by decide
  simp [occ, annih, jwSign, EuclideanSpace.single_apply, h1, h2]
