-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.qcdG2M4_lower
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.ChapterGravityProjector
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.SirkCertifiedGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]


noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision


gap := 1.9875
  width := 0.0555
  width_nonneg := by norm_num

/-- The certified lower bound of the `g = 2`, `m = 4` c := by sorry
