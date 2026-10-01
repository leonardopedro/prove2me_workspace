-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.qcdG2M4_lower
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap



noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
gap := 1.9875
  width := 0.0555
  width_nonneg := by norm_num

/-- The certified lower bound of the `g = 2`, `m = 4` c :=
  ertificate is `1.932`. -/
  theorem qc
