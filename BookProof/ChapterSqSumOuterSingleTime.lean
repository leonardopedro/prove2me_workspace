import Mathlib
import BookProof.ChapterSqSumOuterFamily
import BookProof.ChapterFiniteSectionSingleTime

/-!
# Outer-Fock kinetic-plus-squares families: one shift, one finite time

`BookProof.ChapterSqSumOuterFamily` builds, for a uniform kinetic-plus-squares family
`F` of sector Hamiltonians `H_n = ½ Σ_I κ_I π_I² + ½ Σ_r L_r²`, the Hamiltonian
`F.outerHam` on the finite-particle core of the outer Fock space `⊕ₙ L²(ℝ^{dim n})`, and
proves it symmetric (`outerHam_symmetricOn`) and **essentially self-adjoint already on that
core** (`outerHam_esa`).  What it stops short of is the evolution statement: the propagator
of the selected generator, and a family of computable truncations converging to it.

This module supplies both, for *every* such family, along the route of
`BookProof.ChapterQgTimeIndependentFlow` (quantum gravity) and
`BookProof.ChapterFiniteSectionSingleTime` (mode Hamiltonians), with the **particle-number
truncation** in the role of the mode cutoff.

## The truncation

`F.trunc N` is the same family with the squared forms switched off above particle number
`N`: `vv n = F.vv n` for `n ≤ N` and `vv n = 0` beyond.  The Schur constants are unchanged
(a zero row has zero ℓ¹ norm), so `F.trunc N` is again a `SqFamily`, and everything proved
for a family applies to it — in particular it is essentially self-adjoint on the same core.
Above the cutoff the truncated Hamiltonian is the free kinetic term `½ Σ_I κ_I π_I²`: the
*interaction and constraint* terms are what the cutoff removes, exactly as the quantum
gravity mode truncation switches off the vielbein self-interaction and the
scalaron–vielbein coupling outside a finite window.

## What is proved

* `SqFamily.trunc`, `SqFamily.truncHam`, `trunc_secHam_eq_of_le`,
  `truncHam_eventuallyEq` — the truncated family, its Hamiltonian on the *same*
  finite-particle core, and the fact that on any fixed finite-particle state the truncated
  Hamiltonian *equals* the exact one from some cutoff on.
* `truncHam_symmetricOn`, `truncHam_esa`, `truncHam_tendsto` — the truncated Hamiltonian is
  symmetric and essentially self-adjoint on the core, and converges there to the exact one:
  the hypotheses of the Reed–Simon VIII.25(a) criterion
  `strongResolventConvergence_of_core`.
* **`outerFamily_timeIndependent_singleTime`** — the package: a self-adjoint realization
  `T` of `F.outerHam` and self-adjoint realizations `S N` of the truncations, such that the
  propagator `U(t,s) = e^{−i(t−s)H}` of the one fixed generator is unitary, satisfies
  Chapman–Kolmogorov, is invariant under a common shift of both times and uniquely solves
  the Schrödinger equation; at **every** nonzero shift the Hashimoto shift-invert operators
  of the truncations converge strongly; and hence at **every single finite time** the
  truncated propagators converge to the exact one.

No time stepping, no step size, no Dyson series and no time ordering occurs anywhere.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SqSumOuterFamily

open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.QgTimeIndependent BookProof.QgTruncationResolvent
open BookProof.DirectSumEsa BookProof.HermiteProductCore

noncomputable section

namespace SqFamily

/-! ## 1. The particle-number truncation -/

/-- **The particle-number truncation** of a uniform family: the squared forms are switched
off above particle number `N`, so that above the cutoff only the free kinetic term
`½ Σ_I κ_I π_I²` remains.  The Schur constants are unchanged. -/
def trunc (F : SqFamily) (N : ℕ) : SqFamily where
  dim := F.dim
  R := F.R
  finR := F.finR
  kap := F.kap
  vv := fun n r I => if n ≤ N then F.vv n r I else 0
  km := F.km
  a := F.a
  b := F.b
  km_nonneg := F.km_nonneg
  a_nonneg := F.a_nonneg
  b_nonneg := F.b_nonneg
  kap_le := F.kap_le
  row_le := by
    intro n r
    by_cases h : n ≤ N
    · simpa [h] using F.row_le n r
    · simpa [h] using F.a_nonneg
  col_le := by
    intro n I
    by_cases h : n ≤ N
    · simpa [h] using F.col_le n I
    · simpa [h] using F.b_nonneg

@[simp] theorem trunc_dim (F : SqFamily) (N : ℕ) : (F.trunc N).dim = F.dim := rfl

/-- Below the cutoff the truncated sector Hamiltonian is the exact one. -/
theorem trunc_secHam_eq_of_le (F : SqFamily) {N n : ℕ} (h : n ≤ N) :
    (F.trunc N).secHam n = F.secHam n := by
  have hvv : (F.trunc N).vv n = F.vv n := by
    funext r I
    simp [trunc, h]
  rw [secHam, secHam, hvv]
  rfl

/-- **The truncated Hamiltonian**, on the *same* finite-particle core as the exact one. -/
def truncHam (F : SqFamily) (N : ℕ) : outerCore F.dim →ₗ[ℂ] outerFock F.dim :=
  dsOp (fun n => (F.trunc N).secHam n)

@[simp] theorem truncHam_coe (F : SqFamily) (N : ℕ) (x : outerCore F.dim) (n : ℕ) :
    ((truncHam F N x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n
      = (F.trunc N).secHam n ⟨((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n, x.2.2 n⟩ :=
  rfl

theorem truncHam_symmetricOn (F : SqFamily) (N : ℕ) :
    SymmetricOn (outerCore F.dim) (truncHam F N) :=
  dsOp_symmetricOn _ fun n => (F.trunc N).secHam_symmetricOn n

theorem truncHam_esa (F : SqFamily) (N : ℕ) :
    EssentiallySelfAdjointOn (outerCore F.dim) (truncHam F N) :=
  dsOp_essentiallySelfAdjointOn _ fun n => (F.trunc N).secHam_essentiallySelfAdjointOn n

/-- On a state supported below the cutoff the truncated Hamiltonian *is* the exact one. -/
theorem truncHam_eq_of_support (F : SqFamily) (x : outerCore F.dim) {N : ℕ}
    (hsupp : ∀ n : ℕ, N < n → ((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n = 0) :
    (truncHam F N x : outerFock F.dim) = F.outerHam x := by
  refine lp.ext (funext fun n => ?_)
  have h2 : ((F.outerHam x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n
      = F.secHam n ⟨((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n, x.2.2 n⟩ := rfl
  by_cases h : n ≤ N
  · rw [truncHam_coe, h2, trunc_secHam_eq_of_le F h]
    rfl
  · have hzero : (⟨((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n, x.2.2 n⟩ :
        polyGaussCore (d := F.dim n)) = 0 :=
      Subtype.ext (hsupp n (by omega))
    rw [truncHam_coe, h2, hzero, map_zero, map_zero]

/-- **On every finite-particle state the truncation is eventually exact.** -/
theorem truncHam_eventuallyEq (F : SqFamily) (x : outerCore F.dim) :
    ∀ᶠ N in atTop, (truncHam F N x : outerFock F.dim) = F.outerHam x := by
  obtain ⟨N₀, hN₀⟩ : ∃ N₀ : ℕ, ∀ n : ℕ,
      ((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n ≠ 0 → n ≤ N₀ := by
    obtain ⟨N₀, hN₀⟩ := x.2.1.bddAbove
    exact ⟨N₀, fun n hn => hN₀ hn⟩
  filter_upwards [eventually_ge_atTop N₀] with N hN
  refine truncHam_eq_of_support F x fun n hn => ?_
  by_contra hne
  exact absurd (hN₀ n hne) (by omega)

/-- The truncated Hamiltonians converge to the exact one on the finite-particle core. -/
theorem truncHam_tendsto (F : SqFamily) (x : outerCore F.dim) :
    Tendsto (fun N : ℕ => (truncHam F N x : outerFock F.dim)) atTop (𝓝 (F.outerHam x)) := by
  refine Tendsto.congr' ?_ (tendsto_const_nhds (x := (F.outerHam x : outerFock F.dim)))
  filter_upwards [F.truncHam_eventuallyEq x] with N hN
  exact hN.symm

/-! ## 2. The package: one shift, one finite time -/

/-- **The evolution of an outer-Fock kinetic-plus-squares family is autonomous, and one
finite time suffices.**

For the Hamiltonian `F.outerHam` on the finite-particle core of `⊕ₙ L²(ℝ^{dim n})` and its
particle-number truncations `truncHam F N`:

* `F.outerHam` has a self-adjoint realization `T` (it is essentially self-adjoint on the
  core, so `T` is *the* realization), and each truncation has a self-adjoint realization
  `S N`;
* the propagator `U(t,s)` of `T` is unitary, obeys Chapman–Kolmogorov, is **invariant under
  a common shift of both times** and **uniquely** solves the Schrödinger equation of the one
  fixed generator — no time ordering and no Dyson series occurs;
* at every nonzero shift `ℓ` the bounded Hashimoto shift-invert operators of the truncations
  converge strongly to that of `T`;
* hence at **every single finite time** `t` the truncated propagators converge to the exact
  one.  No step size, number of steps or time splitting appears anywhere. -/
theorem outerFamily_timeIndependent_singleTime (F : SqFamily) :
    ∃ (T : UnboundedSelfAdjoint (outerFock F.dim))
      (S : ℕ → UnboundedSelfAdjoint (outerFock F.dim)),
      IsSelfAdjointExtension F.outerHam T.op ∧
        (∀ N, IsSelfAdjointExtension (truncHam F N) (S N).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : outerFock F.dim), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : outerFock F.dim), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → outerFock F.dim, IsSchrodingerSolution T y →
          ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ N, IsShiftInvertC (S N).op (((l : ℝ) : ℂ) * Complex.I) (-((S N).resCLM l))) ∧
            ∀ u : outerFock F.dim,
              Tendsto (fun N => -((S N).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : outerFock F.dim) (t : ℝ),
          Tendsto (fun N => (S N).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by
  obtain ⟨T, _U, hT, _hflow⟩ :=
    exists_stone_flow_of_esa F.outerHam (outerCore_dense F.dim) F.outerHam_symmetricOn
      F.outerHam_esa
  have hex : ∀ N : ℕ, ∃ S : UnboundedSelfAdjoint (outerFock F.dim),
      IsSelfAdjointExtension (truncHam F N) S.op := by
    intro N
    obtain ⟨S, _, hS, _⟩ :=
      exists_stone_flow_of_esa (truncHam F N) (outerCore_dense F.dim)
        (truncHam_symmetricOn F N) (truncHam_esa F N)
    exact ⟨S, hS⟩
  choose S hS using hex
  have hsrc : StrongResolventConvergence T S :=
    strongResolventConvergence_of_core (Hn := fun N => truncHam F N)
      F.outerHam_esa hT hS (fun x => F.truncHam_tendsto x)
  have hres1 : StrongResAt T S 1 := fun y => hsrc y
  exact ⟨T, S, hT, hS, fun t s => rfl, fun t s x => norm_prop_apply T t s x,
    fun t s r x => prop_apply_prop T t s r x, fun t s h => prop_time_translation T t s h,
    fun _ hy t s => eq_prop_of_isSchrodingerSolution T hy t s,
    fun l hl => ⟨isShiftInvertC_neg_resCLM_shift T hl,
      fun N => isShiftInvertC_neg_resCLM_shift (S N) hl,
      fun u => (strongResAt_of_ne_zero one_ne_zero hl hres1 u).neg⟩,
    fun v t => singleTime_flow_tendsto_of_strongResAt one_ne_zero hres1 v t⟩

end SqFamily

end

end BookProof.SqSumOuterFamily
