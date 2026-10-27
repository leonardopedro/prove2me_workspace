-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.JY_isClosed
import Mathlib
import Definitions.Def_ChapterA1e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {Y : Submodule ℝ V} (hY : IsClosed (Y : Set V)) :
    IsClosed ((JY Y : Submodule ℝ V) : Set V) := by

  -- Since `Jmap` is a linear isometry equivalence, it is a homeomorphism.
  have h_homeo : IsHomeomorph (Jmap : V → V) := by
    convert Homeomorph.isHomeomorph ( Jmap.toHomeomorph ) using 1
    · rfl
  convert h_homeo.isClosedMap Y hY using 1
  rfl
