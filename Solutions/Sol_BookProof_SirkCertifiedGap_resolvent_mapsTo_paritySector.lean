-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.resolvent_mapsTo_paritySector
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_resolvent_commutes_parity
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P R : E →ₗ[ℂ] E} {z : ℂ} {s : ℝ}
    (hcomm : ∀ x, T (P x) = P (T x))
    (hR1 : ∀ x, R (T x - z • x) = x) (hR2 : ∀ x, T (R x) - z • R x = x)
    {x : E} (hx : x ∈ paritySector P s) : R x ∈ paritySector P s := by

  rw [mem_paritySector] at hx ⊢
  rw [← resolvent_commutes_parity hcomm hR1 hR2 x, hx, map_smul]
