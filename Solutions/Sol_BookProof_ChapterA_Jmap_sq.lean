-- Generated from ChapterA1d.lean — solution of BookProof.ChapterA.Jmap_sq
import Mathlib
import Definitions.Def_ChapterA1d
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution (x : V) : Jmap (Jmap x) = -x := by

  change (Complex.I : ℂ) • ((Complex.I : ℂ) • x) = -x
  rw [smul_smul]; simp
