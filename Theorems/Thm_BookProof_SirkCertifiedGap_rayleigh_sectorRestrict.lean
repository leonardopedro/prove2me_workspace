-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.rayleigh_sectorRestrict
import Definitions.Def_ChapterSirkFinitePrecision
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate
open BookProof.SirkCertifiedGap


noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]


theorem BookProof.SirkCertifiedGap.rayleigh_sectorRestrict {T P : E →ₗ[ℂ] E} {s : ℝ} (hcomm : ∀ x, T (P x) = P (T x))
    (y : paritySector P s) : rayleigh (sectorRestrict T P s hcomm) y = rayleigh T (y : E) := by sorry
