-- Generated from ChapterPauliSU2.lean — solution of BookProof.ChapterPauliSU2.spinorAction_trace_of_unitary
import Mathlib
import Definitions.Def_ChapterPauliSU2
open BookProof.ChapterPauliSU2



open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

set_option maxHeartbeats 1000000 in
theorem solution {T : Matrix (Fin 2) (Fin 2) ℂ}
    (hT : Tᴴ * T = 1) (X : Matrix (Fin 2) (Fin 2) ℂ) :
    (spinorAction T X).trace = X.trace := by

  unfold spinorAction;
  convert Matrix.trace_mul_comm _ _ using 2;
  simp [ ← mul_assoc, mul_eq_one_comm.mp hT ]
