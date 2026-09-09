import Mathlib
import BookProof.ChapterSirkEndToEnd
import BookProof.ChapterSirkWhitening

/-!
# Chapter SirkTruncation — the rank-truncated Gram case

`CONSOLIDATED_PLAN.md` §12.2 **Gap 4c** has two halves.  The non-degenerate half
is closed by `ChapterSirkWhitening`: the reduced operator depends only on the
retained subspace, so any two whitenings of the same raw Krylov vectors give the
same reconstructed operator.  The remaining half is the **rank-truncated** case:
the numerics eigendecompose the Gram matrix and discard the directions whose
eigenvalue falls below a relative tolerance, so the retained subspace is a
*proper* subspace of the raw span — and the seed no longer lies exactly inside
it.  What is needed is a bound on the damage.

This chapter supplies it.

* `compress_comp` — **rank truncation is a further compression**: reducing with
  the truncated embedding `V ∘ W` gives `W∗ (V∗XV) W`, the compression of the
  untruncated reduced operator.  So truncation composes with everything the
  previous chapters proved about compressions, in particular the Crouzeix domain
  of `ChapterSirkSpectralGeometry` still applies.
* `sirk_error_bound_at_leaky` — the pointwise Crouzeix core with the transfer
  identity replaced by a **transfer defect** `ρ`: the bound becomes
  `2CD‖v‖ + ρ`.  This is `ChapterSirkEndToEnd.sirk_error_bound_at` with the
  exactness hypothesis relaxed, and it degenerates to it at `ρ = 0`.
* `transfer_defect_le_of_leakage` — the defect is controlled by the **seed
  leakage** `δ = ‖v − P v‖`, the part of the seed the truncation throws away:
  `ρ ≤ ‖r(X)‖ · δ`.  On the retained subspace the transfer is exact (that is
  `ChapterH8.compress_rational_transfer`), so all of the defect comes from the
  discarded directions.
* `sirk_end_to_end_truncated` — the two together: with a rank-truncated Gram the
  end-to-end bound survives with one additive term proportional to the seed
  leakage, and `sirk_end_to_end_truncated_of_exact` recovers the untruncated
  statement when nothing is discarded.

## Honest boundary

The leakage `δ` is the quantity the tolerance controls; relating it to the
*eigenvalues* of the Gram matrix — i.e. proving that a tolerance of `1e-12`
produces a particular `δ` for a particular Hamiltonian — is a numerical-analysis
statement about the computed Gram, and is outside the exact-arithmetic
formalization (§12.2 Gap 6).  What is proved here is that the dependence is the
expected one: linear in the discarded part of the seed, with the constant being
the size of the rational approximant.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkTruncation

open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterSirkEndToEnd
open BookProof.ChapterSirkWhitening

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

/-! ## 1. Rank truncation is a further compression -/

/-- **Truncating the whitened basis is a compression of the reduced operator.**
If `V : F → E` embeds the raw whitened Krylov subspace and `W : G → F` selects
the retained directions, the reduced operator of the truncated basis is the
compression of the untruncated one.  In particular every statement proved for
compressions — the numerical-range inclusions of `ChapterH9`, hence the Crouzeix
domains of `ChapterSirkSpectralGeometry` — applies unchanged after truncation. -/
theorem compress_comp (V : F →L[ℂ] E) (W : G →L[ℂ] F) (X : E →L[ℂ] E) :
    compress (V.comp W) X = compress W (compress V X) := by
  simp [compress, ContinuousLinearMap.adjoint_comp, ContinuousLinearMap.comp_assoc]

omit [CompleteSpace E] [CompleteSpace F] [CompleteSpace G] in
/-- Composing an isometric embedding with an isometric truncation is again
isometric, so the truncated reduction satisfies every hypothesis the untruncated
one does. -/
theorem isometry_comp (V : F →L[ℂ] E) (W : G →L[ℂ] F)
    (hV : ∀ x : F, ‖V x‖ = ‖x‖) (hW : ∀ x : G, ‖W x‖ = ‖x‖) (x : G) :
    ‖(V.comp W) x‖ = ‖x‖ := by
  simp [hV, hW]

/-! ## 2. The Crouzeix core with a transfer defect -/

/-- **The pointwise SIRK bound with a transfer defect.**
`ChapterSirkEndToEnd.sirk_error_bound_at` assumes the rational transfer
`r(X) v = V r(B) V∗ v` *exactly at the seed*.  Under rank truncation the seed is
no longer inside the retained subspace and the identity only holds up to `ρ`.
The bound degrades by exactly that amount. -/
theorem sirk_error_bound_at_leaky
    (V : F →L[ℂ] E) (phiA psiX rX : E →L[ℂ] E) (psiB rB : F →L[ℂ] F)
    (C D rho : ℝ)
    (hphi : phiA = psiX)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hcx1 : ‖psiX - rX‖ ≤ C * D)
    (hcx2 : ‖psiB - rB‖ ≤ C * D)
    (v : E) (hrt : ‖rX v - V (rB (V.adjoint v))‖ ≤ rho) :
    ‖phiA v - sirkApprox V psiB v‖ ≤ 2 * C * D * ‖v‖ + rho := by
  have hCD : 0 ≤ C * D := le_trans (norm_nonneg _) hcx2
  have key : phiA v - sirkApprox V psiB v
      = (psiX - rX) v + (rX v - V (rB (V.adjoint v)))
        + V ((rB - psiB) (V.adjoint v)) := by
    have h1 : V ((rB - psiB) (V.adjoint v))
        = V (rB (V.adjoint v)) - V (psiB (V.adjoint v)) := by
      rw [ContinuousLinearMap.sub_apply, map_sub]
    rw [h1, ContinuousLinearMap.sub_apply, hphi, sirkApprox_apply]
    abel
  rw [key]
  have h1 : ‖(psiX - rX) v‖ ≤ C * D * ‖v‖ :=
    le_trans (ContinuousLinearMap.le_opNorm _ _)
      (mul_le_mul_of_nonneg_right hcx1 (norm_nonneg _))
  have h2 : ‖V ((rB - psiB) (V.adjoint v))‖ ≤ C * D * ‖v‖ := by
    rw [hViso]
    refine le_trans (ContinuousLinearMap.le_opNorm _ _) ?_
    exact mul_le_mul (by simpa only [norm_sub_rev] using hcx2) (hVadj v) (norm_nonneg _) hCD
  calc ‖(psiX - rX) v + (rX v - V (rB (V.adjoint v))) + V ((rB - psiB) (V.adjoint v))‖
      ≤ ‖(psiX - rX) v + (rX v - V (rB (V.adjoint v)))‖
        + ‖V ((rB - psiB) (V.adjoint v))‖ := norm_add_le _ _
    _ ≤ (‖(psiX - rX) v‖ + ‖rX v - V (rB (V.adjoint v))‖)
        + ‖V ((rB - psiB) (V.adjoint v))‖ := by
        gcongr; exact norm_add_le _ _
    _ ≤ (C * D * ‖v‖ + rho) + C * D * ‖v‖ := by gcongr
    _ = 2 * C * D * ‖v‖ + rho := by ring

/-! ## 3. The defect is the discarded part of the seed -/

/-- **The transfer defect is exactly the discarded part of the seed.**  Write
`P = V ∘ V∗` for the reconstruction projection onto the retained subspace and
`δ = ‖v − P v‖` for the part of the seed the rank truncation throws away.  On
the retained subspace the rational transfer is exact — that is
`ChapterH8.compress_rational_transfer`, taken here as the hypothesis `hexact` —
and `V∗` sees nothing of the discarded part (`hproj`, which holds for any
isometric embedding).  So the defect at `v` is at most `‖r(X)‖ · δ`. -/
theorem transfer_defect_le_of_leakage (V : F →L[ℂ] E) (rX : E →L[ℂ] E) (rB : F →L[ℂ] F)
    (v : E) (hexact : rX (V (V.adjoint v)) = V (rB (V.adjoint (V (V.adjoint v)))))
    (hproj : V.adjoint (V (V.adjoint v)) = V.adjoint v) :
    ‖rX v - V (rB (V.adjoint v))‖ ≤ ‖rX‖ * ‖v - V (V.adjoint v)‖ := by
  have hw : rX (V (V.adjoint v)) = V (rB (V.adjoint v)) := by rw [hexact, hproj]
  rw [← hw, ← map_sub]
  exact rX.le_opNorm _

/-- The isometry hypothesis of `transfer_defect_le_of_leakage` is automatic for
an isometric embedding: `V∗V = 1` gives `V∗ (V V∗ v) = V∗ v`, so `V∗` does not
see the discarded directions. -/
theorem adjoint_reconstruction_eq (V : F →L[ℂ] E)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (v : E) :
    V.adjoint (V (V.adjoint v)) = V.adjoint v :=
  congrArg (fun f : F →L[ℂ] F => f (V.adjoint v)) hVV

/-! ## 4. The end-to-end bound under rank truncation -/

/-- **The end-to-end SIRK bound with a rank-truncated Gram (§12.2 Gap 4c, the
remaining half).**  Discarding the near-degenerate directions of the Gram matrix
costs one additive term, proportional to the part of the seed that was
discarded, with the proportionality constant the size of the rational
approximant.  The `e^{−hm}` term is untouched. -/
theorem sirk_end_to_end_truncated
    (V : F →L[ℂ] E) (rX : E →L[ℂ] E) (rB : F →L[ℂ] F)
    (flow psiX : E →L[ℂ] E) (psiB : F →L[ℂ] F) (C Dmin h : ℝ) (m : ℕ)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hflow : flow = psiX)
    (hcx1 : ‖psiX - rX‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcx2 : ‖psiB - rB‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : E) (hexact : rX (V (V.adjoint v)) = V (rB (V.adjoint (V (V.adjoint v)))))
    (hproj : V.adjoint (V (V.adjoint v)) = V.adjoint v) :
    ‖flow v - sirkApprox V psiB v‖
      ≤ sirkBound C Dmin h ‖v‖ m
        + ‖rX‖ * ‖v - V (V.adjoint v)‖ := by
  have hdef := transfer_defect_le_of_leakage V rX rB v hexact hproj
  have := sirk_error_bound_at_leaky V flow psiX rX psiB rB C
    (Real.exp (-(h * m)) * Dmin) _ hflow hViso hVadj hcx1 hcx2 v hdef
  simpa [sirkBound, mul_assoc] using this

/-- With nothing discarded — the seed already inside the retained subspace — the
truncated bound is the untruncated one. -/
theorem sirk_end_to_end_truncated_of_exact
    (V : F →L[ℂ] E) (rX : E →L[ℂ] E) (rB : F →L[ℂ] F)
    (flow psiX : E →L[ℂ] E) (psiB : F →L[ℂ] F) (C Dmin h : ℝ) (m : ℕ)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hflow : flow = psiX)
    (hcx1 : ‖psiX - rX‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcx2 : ‖psiB - rB‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : E) (hv : V (V.adjoint v) = v)
    (hexact : rX (V (V.adjoint v)) = V (rB (V.adjoint (V (V.adjoint v)))))
    (hproj : V.adjoint (V (V.adjoint v)) = V.adjoint v) :
    ‖flow v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by
  have := sirk_end_to_end_truncated V rX rB flow psiX psiB C Dmin h m
    hViso hVadj hflow hcx1 hcx2 v hexact hproj
  simpa [hv] using this

end BookProof.ChapterSirkTruncation
