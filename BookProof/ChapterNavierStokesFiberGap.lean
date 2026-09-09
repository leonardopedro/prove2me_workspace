import Mathlib
import BookProof.ChapterNavierStokesLagrangianCanonical
import BookProof.ChapterNavierStokesDiffFarisLavine
import BookProof.ChapterFriedrichsFormGap

/-!
# Chapter NavierStokesFiberGap — what the Navier–Stokes Eulerian fiber can certify

`CONSOLIDATED_PLAN.md`, next-steps item **3** of the 2026-08-28j block: *instantiate the
chain for NS*, scoping the module to what the fiber operator can actually certify.

The Eulerian-fiber one-particle operator is the Weyl quantization
`H = ∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ)`, `Vᵢ(u) = ∑ₖ A_{ik}uₖ + cᵢ`, of the Navier–Stokes quadratic symbol
(`BookProof.NavierStokesFlow.CanonicalVector.canH`).  It is symmetric and essentially
self-adjoint on the Hermite core, but it is a *first-order* operator: this module proves
that **its quadratic form vanishes on every Hermite basis state**, so it has no
one-particle form gap at any positive level, and the constant/diagonal gap chains
(`ChapterScalaronFockGapChain`, `ChapterFockDiagonalGapChain`) cannot be instantiated for
it — no shift or rescaling repairs this, since a form gap is what those chains consume.

What the fiber *does* carry is the Faris–Lavine comparison operator
`N = 2μ ∑ᵢ (πᵢ² + uᵢ²/4) + 1` (`nsDiffN`), which is positive and dominates the identity.
For it the Friedrichs machinery applies verbatim.

## What is proved

* `ladFun_coreState_self` — the ladder normal form of the fiber Hamiltonian has vanishing
  diagonal coordinate at a Hermite state: raising/lowering moves the multi-index, and the
  two surviving `i = k` families carry the coefficients `coefPair A i i = coefRot A i i = 0`.
* `canH_coreState_self` , **`nsFiber_quadForm_coreState`** — hence the fiber Hamiltonian's
  quadratic form vanishes at every Hermite basis state.
* **`nsFiber_no_form_gap`** — consequently, for every `μ > 0` the one-particle form gap
  `μ‖x‖² ≤ ⟪x, H x⟫` fails on the Hermite core: the Navier–Stokes Eulerian fiber has no
  positive one-particle edge to feed into the Fock gap chain.
* **`nsComparison_friedrichs_gap`** — the honest positive statement for this fiber: the
  Faris–Lavine comparison operator `N = nsDiffN μ` on the Gauss–polynomial core of `L²(ℝ³)`
  has a positive self-adjoint (Friedrichs) extension, which is the operator the Hashimoto
  shift-invert scheme selects at `γ = 1`, and which satisfies `⟪y, N y⟫ ≥ ‖y‖²` on its whole
  domain.

## Honest boundary

The comparison operator is the Faris–Lavine control operator, not the Navier–Stokes
Hamiltonian: its gap is a statement about `N`, and it certifies essential self-adjointness
of `H` (as in `ChapterNavierStokesDiffFarisLavine`), not a spectral gap of `H`.  Nothing
here claims anything about the classical Navier–Stokes regularity problem, and nothing here
gives the Eulerian fiber a mass gap — `nsFiber_no_form_gap` proves that it has none.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.NavierStokesFlow

namespace FiberGap

open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DiffFarisLavine
open LagrangianCanonical
open BookProof.FriedrichsFormGap BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert BookProof.HermiteProductCore
open BookProof.FriedrichsExtension

/-! ## 1. The fiber Hamiltonian has no one-particle form gap -/

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

/-- The coordinates of a Hermite basis state, as a plain function. -/
lemma crd_coreState_apply (β γ : Vel) :
    crd (coreState β) γ = if γ = β then 1 else 0 :=
  crd_coreState β γ

/-- A single lowering never returns to the same multi-index (the amplitude kills the
truncated case `β i = 0`). -/
lemma cFun_coreState_self (i : Fin 3) (β : Vel) :
    cFun i (crd (coreState β)) β = 0 := by
  classical
  rcases Nat.eq_zero_or_pos (β i) with h0 | hpos
  · simp [cFun, h0]
  · have hne : lower i β ≠ β := by
      intro hc
      have := congrFun hc i
      rw [lower_self] at this
      omega
    simp [cFun, crd_coreState_apply, hne]

/-- A single raising never returns to the same multi-index. -/
lemma aFun_coreState_self (i : Fin 3) (β : Vel) :
    aFun i (crd (coreState β)) β = 0 := by
  classical
  have hne : raise i β ≠ β := by
    intro hc
    have := congrFun hc i
    rw [raise_self] at this
    omega
  simp [aFun, crd_coreState_apply, hne]

lemma cFun_cFun_coreState_self (i k : Fin 3) (β : Vel) :
    cFun i (cFun k (crd (coreState β))) β = 0 := by
  classical
  rcases Nat.eq_zero_or_pos (β i) with h0 | hpos
  · simp [cFun, h0]
  rcases Nat.eq_zero_or_pos (lower i β k) with h1 | h1
  · simp [cFun, h1]
  have hne : lower k (lower i β) ≠ β := by
    intro hc
    by_cases hik : i = k
    · subst hik
      have h := congrFun hc i
      rw [lower_self, lower_self] at h
      omega
    · have h := congrFun hc i
      rw [lower_of_ne hik, lower_self] at h
      omega
  simp [cFun, crd_coreState_apply, hne]

lemma aFun_aFun_coreState_self (i k : Fin 3) (β : Vel) :
    aFun i (aFun k (crd (coreState β))) β = 0 := by
  classical
  have hne : raise k (raise i β) ≠ β := by
    intro hc
    by_cases hik : i = k
    · subst hik
      have h := congrFun hc i
      rw [raise_self, raise_self] at h
      omega
    · have h := congrFun hc i
      rw [raise_of_ne hik, raise_self] at h
      omega
  simp [aFun, crd_coreState_apply, hne]

lemma cFun_aFun_coreState_self_of_ne {i k : Fin 3} (h : i ≠ k) (β : Vel) :
    cFun i (aFun k (crd (coreState β))) β = 0 := by
  classical
  rcases Nat.eq_zero_or_pos (β i) with h0 | hpos
  · simp [cFun, h0]
  have hne : raise k (lower i β) ≠ β := by
    intro hc
    have h1 := congrFun hc i
    rw [raise_of_ne h, lower_self] at h1
    omega
  simp [cFun, aFun, crd_coreState_apply, hne]

lemma aFun_cFun_coreState_self_of_ne {i k : Fin 3} (h : i ≠ k) (β : Vel) :
    aFun i (cFun k (crd (coreState β))) β = 0 := by
  classical
  have hne : lower k (raise i β) ≠ β := by
    intro hc
    have h1 := congrFun hc i
    rw [lower_of_ne h, raise_self] at h1
    omega
  simp [aFun, cFun, crd_coreState_apply, hne]

/-- **The ladder normal form has vanishing diagonal at a Hermite state.** -/
lemma ladFun_coreState_self (β : Vel) :
    ladFun A c (crd (coreState β)) β = 0 := by
  classical
  have hdiag : ∀ i : Fin 3, ((A i i / 2 : ℝ) : ℂ) *
      (cFun i (cFun i (crd (coreState β))) β
        - aFun i (aFun i (crd (coreState β))) β) = 0 := by
    intro i
    rw [cFun_cFun_coreState_self, aFun_aFun_coreState_self]
    ring
  have hmom : ∀ i : Fin 3, ((c i / Real.sqrt 2 : ℝ) : ℂ) *
      (cFun i (crd (coreState β)) β - aFun i (crd (coreState β)) β) = 0 := by
    intro i
    rw [cFun_coreState_self, aFun_coreState_self]
    ring
  have hpair : ∀ i k : Fin 3, ((coefPair A i k : ℝ) : ℂ) *
      (cFun i (cFun k (crd (coreState β))) β
        - aFun i (aFun k (crd (coreState β))) β) = 0 := by
    intro i k
    rw [cFun_cFun_coreState_self, aFun_aFun_coreState_self]
    ring
  have hrot : ∀ i k : Fin 3, ((coefRot A i k : ℝ) : ℂ) *
      (cFun i (aFun k (crd (coreState β))) β
        - aFun i (cFun k (crd (coreState β))) β) = 0 := by
    intro i k
    by_cases hik : i = k
    · subst hik
      simp [coefRot]
    · rw [cFun_aFun_coreState_self_of_ne hik, aFun_cFun_coreState_self_of_ne hik]
      ring
  rw [ladFun, Finset.sum_congr rfl (fun i _ => hdiag i),
    Finset.sum_congr rfl (fun i _ => hmom i),
    Finset.sum_congr rfl (fun i _ => Finset.sum_congr rfl (fun k _ => hpair i k)),
    Finset.sum_congr rfl (fun i _ => Finset.sum_congr rfl (fun k _ => hrot i k))]
  simp

/-- **The fiber Hamiltonian has vanishing diagonal matrix element** at every Hermite basis
state. -/
lemma canH_coreState_self (β : Vel) :
    crd (canH A c (coreState β)) β = 0 := by
  rw [canH_crd, canFun_eq_ladFun, ladFun_coreState_self]

/-- **The Navier–Stokes fiber quadratic form vanishes at every Hermite basis state.** -/
theorem nsFiber_quadForm_coreState (β : Vel) :
    quadForm ((lpFiniteModes Vel).subtype.comp (canH A c)) (coreState β) = 0 := by
  classical
  have hinner : (inner ℂ ((coreState β : lpFiniteModes Vel) : L2I Vel)
      (((lpFiniteModes Vel).subtype.comp (canH A c)) (coreState β)) : ℂ) = 0 := by
    have h : ((coreState β : lpFiniteModes Vel) : L2I Vel) = lp.single 2 β (1 : ℂ) := rfl
    rw [h, lp.inner_single_left]
    have := canH_coreState_self A c β
    simp only [crd, LinearMap.comp_apply, Submodule.subtype_apply] at this ⊢
    rw [this]
    simp
  simp only [quadForm, hinner, Complex.zero_re]

theorem norm_coreState (β : Vel) : ‖((coreState β : lpFiniteModes Vel) : L2I Vel)‖ = 1 := by
  have h : ((coreState β : lpFiniteModes Vel) : L2I Vel) = lp.single 2 β (1 : ℂ) := rfl
  rw [h, lp.norm_single (by norm_num)]
  simp

/-- **The Navier–Stokes Eulerian fiber has no one-particle form gap.**  For every `μ > 0`
there is a unit core vector whose energy is `0 < μ‖x‖²`; so no positive one-particle edge
exists to feed the Fock gap chains. -/
theorem nsFiber_no_form_gap {mu : ℝ} (hmu : 0 < mu) :
    ¬ ∀ x : lpFiniteModes Vel,
      mu * ‖(x : L2I Vel)‖ ^ 2 ≤ quadForm ((lpFiniteModes Vel).subtype.comp (canH A c)) x := by
  intro hgap
  have h := hgap (coreState 0)
  rw [nsFiber_quadForm_coreState, norm_coreState] at h
  simp at h
  linarith

/-! ## 2. What the fiber does certify: the Faris–Lavine comparison operator -/

set_option maxHeartbeats 1000000 in
-- Unfolding the Gauss–polynomial core against the bundled `PosSymOp` record is
-- instance-heavy; the default heartbeat budget is not enough.
/-- **The Faris–Lavine comparison operator of the Navier–Stokes fiber has a positive
self-adjoint extension with the form gap `1`.**  The Friedrichs extension of
`N = 2μ ∑ᵢ (πᵢ² + uᵢ²/4) + 1` on the Gauss–polynomial core of `L²(ℝ³)` is a positive
self-adjoint extension, is the operator the Hashimoto shift-invert selects at `γ = 1`, and
satisfies `⟪y, N y⟫ ≥ ‖y‖²` on its whole domain. -/
theorem nsComparison_friedrichs_gap {mu : ℝ} (hmu : 0 ≤ mu) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (N : Dom →ₗ[ℂ] L2d 3) (S : L2d 3 →L[ℂ] L2d 3),
      IsPositiveSelfAdjointExtension
          ((polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)) N ∧
        IsShiftInvert N 1 S ∧ IsSelfAdjoint S ∧
        ∀ y : Dom, 1 * ‖(y : L2d 3)‖ ^ 2 ≤ quadForm N y := by
  have hgap : ∀ f : polyGaussCore (d := 3),
      1 * ‖(f : L2d 3)‖ ^ 2
        ≤ quadForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)) f := by
    intro f
    rw [one_mul]
    exact nsDiffN_quadForm_ge_norm_sq mu hmu f
  have hpos : ∀ f : polyGaussCore (d := 3),
      0 ≤ quadForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)) f := by
    intro f
    have h1 := hgap f
    have h2 : (0 : ℝ) ≤ 1 * ‖(f : L2d 3)‖ ^ 2 := by positivity
    linarith
  let P : PosSymOp (L2d 3) :=
    { dom := polyGaussCore (d := 3)
      op := (polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)
      sym := nsDiffN_symmetricOn mu
      pos := hpos }
  exact friedrichs_extension_form_gap P polyGaussCore_dense hgap

end FiberGap

end BookProof.NavierStokesFlow

end
