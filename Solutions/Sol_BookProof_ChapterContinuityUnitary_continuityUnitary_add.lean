-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.continuityUnitary_add
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
ary_add (v : ZMod N → ℝ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * C :=
  omplex.I) • continuityHamiltonian v) := by
