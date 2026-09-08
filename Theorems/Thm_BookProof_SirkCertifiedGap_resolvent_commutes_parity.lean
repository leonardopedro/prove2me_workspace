-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.resolvent_commutes_parity
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap










noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

theorem BookProof.SirkCertifiedGap.resolvent_commutes_parity {T P R : E →ₗ[ℂ] E} {z : ℂ}
    (hcomm : ∀ x, T (P x) = P (T x))
    (hR1 : ∀ x, R (T x - z • x) = x) (hR2 : ∀ x, T (R x) - z • R x = x) (x : E) :
    R (P x) = P (R x) := by sorry
