import Mathlib
import BookProof.ChapterQgOuterFockEsa
import BookProof.ChapterFriedrichsExtension

/-!
# Faris–Lavine on the outer Fock space: the lifted Friedrichs comparison operator

`BookProof.ChapterQgOuterFockEsa` proves that the full gauge-fixed gravity Hamiltonian is
essentially self-adjoint on the finite-particle core of the outer Fock space
`𝔉 = ⊕ₙ L²(ℝ^{84n})`, by the Carleman route sector by sector.  This module builds the
**Faris–Lavine apparatus on the outer Fock space itself**, with the comparison operator
that the strategy calls for: the Friedrichs extension of the positive one-particle
operator `N₁ = −Δ + ‖x‖²/4`, lifted to `𝔉`.

Theorem 1 of Faris–Lavine (`BookProof.ChapterFarisLavine`) needs exactly three things of
its comparison operator `N`: symmetry, positivity, and that `N + 1` maps the domain
**onto** the space — the one consequence of self-adjointness the argument uses.  The point
of this module is that all three survive the two constructions the strategy chains
together:

* **Friedrichs.**  `friedrichsComparison` packages the Friedrichs extension of
  `BookProof.ChapterFriedrichsExtension` as such a comparison operator: the extension is
  built there as `S⁻¹ − 1` for the resolvent `S = (P+1)⁻¹`, so `N + 1` is onto by
  construction.  `Comparison.selfAdjoint` shows conversely that these three properties
  *are* self-adjointness, so `Comparison.isPositiveSelfAdjointExtension` produces the
  project's `IsPositiveSelfAdjointExtension` predicate.
* **Lifting.**  `dsComparison` lifts a family of fibre comparison operators to the
  `ℓ²`-direct sum, on the maximal domain `dsDom`.  Symmetry and positivity are fibrewise
  (`dsCompOp_hasSum_quadForm`), and surjectivity of `N + 1` lifts because the fibre
  solutions obey `‖xᵢ‖ ≤ ‖(Nᵢ+1)xᵢ‖ = ‖fᵢ‖` (`norm_le_norm_shift`), so they are
  automatically square-summable (`dsCompOp_surj`).  This is the precise sense in which
  "the Friedrichs extension of the positive one-particle operator lifts to an operator on
  the outer Fock space".

## What is proved

* `Comparison`, `Comparison.selfAdjoint`, `Comparison.isPositiveSelfAdjointExtension`,
  `Comparison.essentiallySelfAdjointOn`, `Comparison.esa_self` — comparison operators and
  the Faris–Lavine criterion packaged with one; a comparison operator is essentially
  self-adjoint on its own domain (the case `H = N`, `c = 0`).
* `friedrichsComparison`, `friedrichsComparison_extends` — every densely defined positive
  symmetric operator has one, namely its Friedrichs extension.
* `dsDom`, `dsCompOp`, `dsComparison`, `dsCompOp_surj` — the lift to an `ℓ²`-direct sum.
* `dsFibOp`, `dsFibOp_symmetricOn`, `dsFibOp_hasSum_commForm`, `dsFibOp_commForm_le` — a
  fibrewise symmetric operator on the lifted domain, under a relative bound
  `‖Hᵢu‖ ≤ K‖(Nᵢ+1)u‖` uniform in the fibre; **the commutator form of the lift is the sum
  of the fibre commutator forms**, so the Faris–Lavine bound `±i[H,N] ≤ cN` lifts with the
  *same* constant `c`.
* `dsFibOp_essentiallySelfAdjointOn` — **Faris–Lavine on an `ℓ²`-direct sum**: uniform
  fibre data gives essential self-adjointness of the direct-sum operator on the lifted
  domain.
* `harmPosSym`, `harmFried`, `harmFried_isPositiveSelfAdjointExtension` — the positive
  one-particle gravity operator `N₁ = −Δ + ‖x‖²/4` and its Friedrichs extension.
* `qgOuterComparison`, `qgOuterFriedDom`, `qgOuterFriedN`, `qgOuterFriedN_surj`,
  `qgOuterCore_le_friedDom`, `qgOuterFriedN_isPositiveSelfAdjointExtension`,
  `qgOuterFriedN_esa` — **the lifted comparison operator on the outer Fock space**: it is
  a positive self-adjoint extension of the finite-particle-core operator `dΓ(N₁)`
  (`qgOuterN`), `𝑁 + 1` is onto `𝔉`, and it is essentially self-adjoint on its domain.
* `qgOuterFock_esa_farisLavine` — **the Faris–Lavine theorem for the gravity Hamiltonian
  on the outer Fock space**: given sector realizations of the `n`-particle Hamiltonians on
  the domain of the sector comparison operator that are symmetric, relatively bounded by
  `N + 1` and satisfy `±i[H,N] ≤ cN`, all with constants uniform in the particle number,
  the lifted Hamiltonian is essentially self-adjoint on the lifted domain and extends the
  outer Fock Hamiltonian `qgOuterHam` on the finite-particle core.

## Honest boundary

The sector data of `qgOuterFock_esa_farisLavine` are hypotheses, not theorems of this
module: extending the `n`-particle quadratic Hamiltonian from the Gauss–polynomial core to
the *whole* domain of the sector oscillator, with a relative bound and a commutator bound
whose constants do not degrade as the particle number grows, is a separate analytic step
(the Hermite matrix elements of `BookProof.FullQuadratic.fqOp_hermiteCore` are the natural
route to it) and is not carried out here.  What is unconditional here is everything about
the comparison operator — the Friedrichs extension, its lift, and the fact that
Faris–Lavine applies on the outer Fock space once the sector data are supplied, with the
same constant `c` — together with the observation that uniformity in the particle number
is the only thing the lift asks for.  The *unconditional* essential self-adjointness of
the gravity Hamiltonian on the finite-particle core is proved, by the independent Carleman
route, in `BookProof.ChapterQgOuterFockEsa` (`qgOuterFock_esa`).

Everything in this module is `sorry`-free and `axiom`-free.
-/

open scoped ENNReal

namespace BookProof.QgOuterFockFL

open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HashimotoShiftInvert
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore

noncomputable section

/-! ## 1. Comparison operators for the Faris–Lavine criterion -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- A positive symmetric operator obeys `‖x‖ ≤ ‖A x + x‖`: the shift `A + 1` is bounded
below, hence injective. -/
theorem norm_le_norm_shift {D : Submodule ℂ F} (A : D →ₗ[ℂ] F)
    (hpos : ∀ x : D, 0 ≤ quadForm A x) (x : D) : ‖(x : F)‖ ≤ ‖A x + (x : F)‖ := by
  have hre : ‖(x : F)‖ ^ 2 ≤ (inner ℂ (x : F) (A x + (x : F)) : ℂ).re := by
    rw [inner_add_right, Complex.add_re]
    have h1 : (inner ℂ (x : F) ((x : F)) : ℂ).re = ‖(x : F)‖ ^ 2 := by
      simpa using inner_self_eq_norm_sq (𝕜 := ℂ) (x : F)
    have h2 := hpos x
    rw [quadForm] at h2
    linarith
  have hcs : (inner ℂ (x : F) (A x + (x : F)) : ℂ).re ≤ ‖(x : F)‖ * ‖A x + (x : F)‖ := by
    calc (inner ℂ (x : F) (A x + (x : F)) : ℂ).re
        ≤ ‖(inner ℂ (x : F) (A x + (x : F)) : ℂ)‖ := Complex.re_le_norm _
      _ ≤ ‖(x : F)‖ * ‖A x + (x : F)‖ := norm_inner_le_norm _ _
  rcases eq_or_lt_of_le (norm_nonneg (x : F)) with h | h
  · rw [← h]; exact norm_nonneg _
  · nlinarith

/-- **A Faris–Lavine comparison operator**: a positive symmetric operator whose shift
`N + 1` maps the domain onto the whole space.  These are exactly the three properties of
the comparison operator that Theorem 1 of Faris–Lavine uses; by
`comparison_isPositiveSelfAdjointExtension` they say precisely that `N` is a positive
self-adjoint operator. -/
structure Comparison (F : Type*) [NormedAddCommGroup F] [InnerProductSpace ℂ F] where
  /-- The domain of the comparison operator. -/
  dom : Submodule ℂ F
  /-- The comparison operator. -/
  op : dom →ₗ[ℂ] F
  /-- It is symmetric. -/
  sym : SymmetricOn dom op
  /-- It is positive. -/
  pos : ∀ x : dom, 0 ≤ quadForm op x
  /-- `N + 1` maps the domain onto the space. -/
  surj : ∀ f : F, ∃ x : dom, op x + (x : F) = f

/-- The comparison operator is self-adjoint: every vector that behaves like a domain
vector is one.  Only symmetry and surjectivity of `N + 1` are used. -/
theorem Comparison.selfAdjoint (C : Comparison F) (w u : F)
    (hw : ∀ v : C.dom, (inner ℂ (C.op v) w : ℂ) = inner ℂ (v : F) u) :
    ∃ h : w ∈ C.dom, C.op ⟨w, h⟩ = u := by
  obtain ⟨x, hx⟩ := C.surj (u + w)
  have hperp : ∀ v : C.dom, (inner ℂ (C.op v + (v : F)) (w - (x : F)) : ℂ) = 0 := by
    intro v
    calc (inner ℂ (C.op v + (v : F)) (w - (x : F)) : ℂ)
        = ((inner ℂ (C.op v) w : ℂ) - inner ℂ (C.op v) (x : F))
            + ((inner ℂ (v : F) w : ℂ) - inner ℂ (v : F) (x : F)) := by
          rw [inner_add_left, inner_sub_right, inner_sub_right]
      _ = (inner ℂ (v : F) (u + w) : ℂ) - inner ℂ (v : F) (C.op x + (x : F)) := by
          rw [hw v, C.sym v x, inner_add_right, inner_add_right]
          ring
      _ = 0 := by rw [hx]; ring
  have hzero : w - (x : F) = 0 := by
    obtain ⟨y, hy⟩ := C.surj (w - (x : F))
    have hy0 := hperp y
    rw [hy] at hy0
    exact inner_self_eq_zero.mp hy0
  have hwx : w = (x : F) := sub_eq_zero.mp hzero
  refine ⟨hwx ▸ x.2, ?_⟩
  have hxe : (⟨w, hwx ▸ x.2⟩ : C.dom) = x := Subtype.ext hwx
  rw [hxe]
  have hfin : C.op x + (x : F) = u + (x : F) := by rw [hx, hwx]
  exact add_right_cancel hfin

/-- A comparison operator is a positive self-adjoint extension of every restriction of
it — in particular of the symmetric operator it was built from. -/
theorem Comparison.isPositiveSelfAdjointExtension (C : Comparison F) {D : Submodule ℂ F}
    (H : D →ₗ[ℂ] F) (hHD : ∀ x : D, ∃ h : (x : F) ∈ C.dom, C.op ⟨(x : F), h⟩ = H x) :
    IsPositiveSelfAdjointExtension H C.op :=
  ⟨hHD, C.sym, C.pos, C.selfAdjoint⟩

/-- **The Faris–Lavine criterion, packaged with a comparison operator.** -/
theorem Comparison.essentiallySelfAdjointOn [CompleteSpace F] (C : Comparison F)
    (H : C.dom →ₗ[ℂ] F) (hH : SymmetricOn C.dom H) (c : ℝ) (hc : 0 ≤ c)
    (hcomm : ∀ x : C.dom, |commForm H C.op x| ≤ c * quadForm C.op x) :
    EssentiallySelfAdjointOn C.dom H :=
  essentiallySelfAdjointOn_of_farisLavine H C.op c hH C.sym hc C.pos
    (fun f => C.surj f) hcomm

/-- A comparison operator is essentially self-adjoint on its own domain — the case
`H = N`, `c = 0` of the criterion. -/
theorem Comparison.esa_self [CompleteSpace F] (C : Comparison F) :
    EssentiallySelfAdjointOn C.dom C.op := by
  refine C.essentiallySelfAdjointOn C.op C.sym 0 le_rfl fun x => ?_
  have : commForm C.op C.op x = 0 := by simp [commForm]
  simp [this]

/-- **The Friedrichs extension is a Faris–Lavine comparison operator.**  Every densely
defined positive symmetric operator has one: the resolvent `S = (P+1)⁻¹` built in
`BookProof.ChapterFriedrichsExtension` inverts the shift by construction. -/
def friedrichsComparison [CompleteSpace F] (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    Comparison F where
  dom := LinearMap.range (friedrichsResolvent P : F →ₗ[ℂ] F)
  op := invShiftOperator (friedrichsResolvent P) (friedrichsResolvent_injective P hdense) 1
  sym := invShiftOperator_symmetricOn _ _ _ (friedrichsResolvent_isSelfAdjoint P)
  pos := invShiftOperator_quadForm_nonneg _ _ _ (friedrichsResolvent_pos P)
  surj := by
    intro f
    have hinj : Function.Injective (friedrichsResolvent P) :=
      friedrichsResolvent_injective P hdense
    refine ⟨⟨friedrichsResolvent P f, ⟨f, rfl⟩⟩, ?_⟩
    have hpre : preim (friedrichsResolvent P) ⟨friedrichsResolvent P f, ⟨f, rfl⟩⟩ = f :=
      preim_eq _ hinj _ rfl
    rw [invShiftOperator_apply, hpre]
    push_cast
    module

/-- The Friedrichs comparison operator extends the operator it was built from. -/
theorem friedrichsComparison_extends [CompleteSpace F] (P : PosSymOp F)
    (hdense : Dense (P.dom : Set F)) (x : P.dom) :
    ∃ h : (x : F) ∈ (friedrichsComparison P hdense).dom,
      (friedrichsComparison P hdense).op ⟨(x : F), h⟩ = P.op x := by
  have hinj : Function.Injective (friedrichsResolvent P) :=
    friedrichsResolvent_injective P hdense
  refine ⟨dom_le_range P x.2, ?_⟩
  have hpre : preim (friedrichsResolvent P) ⟨(x : F), dom_le_range P x.2⟩ = (x : F) + P.op x :=
    preim_eq _ hinj _ (friedrichsResolvent_shift P x)
  change invShiftOperator (friedrichsResolvent P) hinj 1 ⟨(x : F), dom_le_range P x.2⟩ = P.op x
  rw [invShiftOperator_apply, hpre]
  push_cast
  module

end Abstract

/-! ## 2. Lifting a comparison operator to an `ℓ²`-direct sum -/

section Lift

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

/-- Squares of `ℝ≥0∞`-exponent two are ordinary squares. -/
theorem rpow_two_eq (a : ℝ) : a ^ (2 : ℝ≥0∞).toReal = a ^ (2 : ℕ) := by
  simp [ENNReal.toReal_ofNat]

open Classical in
/-- An operator on a submodule, extended by zero to the whole space. -/
def opTot {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] {D : Submodule ℂ H}
    (A : D →ₗ[ℂ] H) (v : H) : H := if h : v ∈ D then A ⟨v, h⟩ else 0

theorem opTot_of_mem {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    {D : Submodule ℂ H} (A : D →ₗ[ℂ] H) {v : H} (h : v ∈ D) : opTot A v = A ⟨v, h⟩ := by
  classical
  rw [opTot, dif_pos h]

theorem opTot_zero {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    {D : Submodule ℂ H} (A : D →ₗ[ℂ] H) : opTot A 0 = 0 := by
  rw [opTot_of_mem A (Submodule.zero_mem D)]
  have hz : (⟨(0 : H), Submodule.zero_mem D⟩ : D) = 0 := rfl
  rw [hz, map_zero]

theorem opTot_add {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    {D : Submodule ℂ H} (A : D →ₗ[ℂ] H) {u v : H} (hu : u ∈ D) (hv : v ∈ D) :
    opTot A (u + v) = opTot A u + opTot A v := by
  rw [opTot_of_mem A (Submodule.add_mem D hu hv), opTot_of_mem A hu, opTot_of_mem A hv]
  exact map_add A ⟨u, hu⟩ ⟨v, hv⟩

theorem opTot_smul {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    {D : Submodule ℂ H} (A : D →ₗ[ℂ] H) (c : ℂ) {v : H} (hv : v ∈ D) :
    opTot A (c • v) = c • opTot A v := by
  rw [opTot_of_mem A (Submodule.smul_mem D c hv), opTot_of_mem A hv]
  exact map_smul A c ⟨v, hv⟩

variable (C : ∀ i, Comparison (G i))

/-- **The domain of the lifted comparison operator**: the vectors of the direct sum whose
fibres lie in the fibre domains and whose images are again square-summable. -/
def dsDom : Submodule ℂ (lp G 2) where
  carrier := {x | (∀ i, (x : ∀ i, G i) i ∈ (C i).dom) ∧
    Memℓp (fun i => opTot (C i).op ((x : ∀ i, G i) i)) 2}
  add_mem' := by
    rintro x y ⟨hx, hxm⟩ ⟨hy, hym⟩
    refine ⟨fun i => by
      simpa only [lp.coeFn_add, Pi.add_apply] using Submodule.add_mem _ (hx i) (hy i), ?_⟩
    have hfun : (fun i => opTot (C i).op (((x + y : lp G 2)) i))
        = (fun i => opTot (C i).op ((x : lp G 2) i))
          + fun i => opTot (C i).op ((y : lp G 2) i) := by
      funext i
      simp only [lp.coeFn_add, Pi.add_apply]
      exact opTot_add _ (hx i) (hy i)
    rw [hfun]
    exact hxm.add hym
  zero_mem' := by
    refine ⟨fun i => by simp, ?_⟩
    have hfun : (fun i => opTot (C i).op (((0 : lp G 2)) i)) = fun i => (0 : G i) := by
      funext i
      have h0 : ((0 : lp G 2) : ∀ i, G i) i = 0 := by simp
      rw [h0]
      exact opTot_zero (C i).op
    rw [hfun]
    exact zero_memℓp
  smul_mem' := by
    rintro a x ⟨hx, hxm⟩
    refine ⟨fun i => by
      simpa only [lp.coeFn_smul, Pi.smul_apply] using Submodule.smul_mem _ a (hx i), ?_⟩
    have hfun : (fun i => opTot (C i).op (((a • x : lp G 2)) i))
        = a • fun i => opTot (C i).op ((x : lp G 2) i) := by
      funext i
      simp only [lp.coeFn_smul, Pi.smul_apply]
      exact opTot_smul _ a (hx i)
    rw [hfun]
    exact hxm.const_smul a

theorem mem_dsDom {x : lp G 2} :
    x ∈ dsDom C ↔ (∀ i, (x : ∀ i, G i) i ∈ (C i).dom) ∧
      Memℓp (fun i => opTot (C i).op ((x : ∀ i, G i) i)) 2 := Iff.rfl

/-- **The lifted comparison operator** `⊕ᵢ Nᵢ`. -/
def dsCompOp : dsDom C →ₗ[ℂ] lp G 2 where
  toFun x := ⟨fun i => opTot (C i).op ((x : lp G 2) i), x.2.2⟩
  map_add' x y := by
    refine lp.ext (funext fun i => ?_)
    change opTot (C i).op (((x + y : dsDom C) : lp G 2) i) = _
    simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    exact opTot_add _ (x.2.1 i) (y.2.1 i)
  map_smul' a x := by
    refine lp.ext (funext fun i => ?_)
    change opTot (C i).op (((a • x : dsDom C) : lp G 2) i) = _
    simp only [SetLike.val_smul, lp.coeFn_smul, Pi.smul_apply, RingHom.id_apply]
    exact opTot_smul _ a (x.2.1 i)

@[simp] theorem dsCompOp_coe (x : dsDom C) (i : ι) :
    ((dsCompOp C x : lp G 2) : ∀ i, G i) i = opTot (C i).op ((x : lp G 2) i) := rfl

/-- The fibre of a domain vector, as an element of the fibre domain. -/
def fib (x : dsDom C) (i : ι) : (C i).dom := ⟨(x : lp G 2) i, x.2.1 i⟩

@[simp] theorem dsCompOp_fib (x : dsDom C) (i : ι) :
    ((dsCompOp C x : lp G 2) : ∀ i, G i) i = (C i).op (fib C x i) :=
  opTot_of_mem _ (x.2.1 i)

theorem dsCompOp_symmetricOn : SymmetricOn (dsDom C) (dsCompOp C) := by
  intro x y
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun i => ?_
  rw [dsCompOp_fib, dsCompOp_fib]
  exact (C i).sym (fib C x i) (fib C y i)

/-- The quadratic form of the lift is the sum of the fibre quadratic forms. -/
theorem dsCompOp_hasSum_quadForm (x : dsDom C) :
    HasSum (fun i => quadForm (C i).op (fib C x i)) (quadForm (dsCompOp C) x) := by
  have hsum : HasSum (fun i => (inner ℂ ((x : lp G 2) i) ((dsCompOp C x : lp G 2) i) : ℂ))
      (inner ℂ (x : lp G 2) (dsCompOp C x : lp G 2)) := lp.hasSum_inner _ _
  have hre := Complex.reCLM.hasSum hsum
  have hfun : (fun i => Complex.reCLM
        (inner ℂ ((x : lp G 2) i) ((dsCompOp C x : lp G 2) i) : ℂ))
      = fun i => quadForm (C i).op (fib C x i) := by
    funext i
    rw [Complex.reCLM_apply, quadForm, dsCompOp_fib]
    rfl
  rw [hfun] at hre
  exact hre

theorem dsCompOp_quadForm_nonneg (x : dsDom C) : 0 ≤ quadForm (dsCompOp C) x :=
  hasSum_le (fun i => (C i).pos (fib C x i)) hasSum_zero (dsCompOp_hasSum_quadForm C x)

/-- **The shift of the lift is onto.**  Given `f`, solve fibrewise; the solutions are
square-summable because `‖xᵢ‖ ≤ ‖(Nᵢ+1)xᵢ‖ = ‖fᵢ‖`. -/
theorem dsCompOp_surj (f : lp G 2) : ∃ x : dsDom C, dsCompOp C x + (x : lp G 2) = f := by
  choose u hu using fun i => (C i).surj ((f : ∀ i, G i) i)
  have hbound : ∀ i, ‖((u i : G i))‖ ≤ ‖(f : ∀ i, G i) i‖ := by
    intro i
    have := norm_le_norm_shift (C i).op (C i).pos (u i)
    rwa [hu i] at this
  have hmem : Memℓp (fun i => ((u i : G i))) 2 := by
    refine memℓp_gen ?_
    have hfs : Summable (fun i => ‖(f : ∀ i, G i) i‖ ^ (2 : ℝ≥0∞).toReal) :=
      (lp.memℓp f).summable (by norm_num)
    refine Summable.of_nonneg_of_le (fun i => by positivity) (fun i => ?_) hfs
    rw [rpow_two_eq, rpow_two_eq]
    exact pow_le_pow_left₀ (norm_nonneg _) (hbound i) 2
  set x : lp G 2 := ⟨fun i => ((u i : G i)), hmem⟩ with hxdef
  have hxfib : ∀ i, (x : ∀ i, G i) i = (u i : G i) := fun i => rfl
  have hxmem : x ∈ dsDom C := by
    refine ⟨fun i => by rw [hxfib]; exact (u i).2, ?_⟩
    have hfun : (fun i => opTot (C i).op ((x : ∀ i, G i) i))
        = fun i => (f : ∀ i, G i) i - (x : ∀ i, G i) i := by
      funext i
      rw [hxfib, opTot_of_mem _ (u i).2]
      have : (⟨(u i : G i), (u i).2⟩ : (C i).dom) = u i := Subtype.ext rfl
      rw [this, ← hu i]
      abel
    rw [hfun]
    have hsub := lp.memℓp (f - x)
    have hcoe : ((f - x : lp G 2) : ∀ i, G i)
        = fun i => (f : ∀ i, G i) i - (x : ∀ i, G i) i := funext fun i => by simp
    rw [hcoe] at hsub
    exact hsub
  refine ⟨⟨x, hxmem⟩, ?_⟩
  refine lp.ext (funext fun i => ?_)
  simp only [lp.coeFn_add, Pi.add_apply]
  rw [dsCompOp_fib]
  have hfibx : fib C ⟨x, hxmem⟩ i = u i := Subtype.ext (hxfib i)
  rw [hfibx, hxfib]
  exact hu i

/-- **The lift of a family of comparison operators is a comparison operator.**  This is
the step the Faris–Lavine strategy needs: positivity, symmetry and — crucially —
invertibility of `N + 1` all survive the passage to the `ℓ²`-direct sum. -/
def dsComparison : Comparison (lp G 2) where
  dom := dsDom C
  op := dsCompOp C
  sym := dsCompOp_symmetricOn C
  pos := dsCompOp_quadForm_nonneg C
  surj := dsCompOp_surj C

/-! ### The commutator form of a fibrewise operator -/

variable (H : ∀ i, (C i).dom →ₗ[ℂ] G i)

/-- The fibrewise operator `⊕ᵢ Hᵢ` on the lifted domain, under a uniform relative bound
`‖Hᵢ u‖ ≤ K‖(Nᵢ+1)u‖` — the bound that makes the image square-summable. -/
def dsFibOp (K : ℝ) (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖) :
    dsDom C →ₗ[ℂ] lp G 2 where
  toFun x := ⟨fun i => opTot (H i) ((x : lp G 2) i), by
    refine memℓp_gen ?_
    have hbig := lp.memℓp (dsCompOp C x + (x : lp G 2))
    have hcoe : ((dsCompOp C x + (x : lp G 2) : lp G 2) : ∀ i, G i)
        = fun i => (dsCompOp C x : lp G 2) i + (x : lp G 2) i := funext fun i => by simp
    rw [hcoe] at hbig
    have hs : Summable (fun i => ‖(dsCompOp C x : lp G 2) i + (x : lp G 2) i‖
        ^ (2 : ℝ≥0∞).toReal) := hbig.summable (by norm_num)
    have hsK : Summable (fun i => (K ^ 2) * ‖(dsCompOp C x : lp G 2) i + (x : lp G 2) i‖
        ^ (2 : ℝ≥0∞).toReal) := hs.mul_left _
    refine Summable.of_nonneg_of_le (fun i => by positivity) (fun i => ?_) hsK
    rw [rpow_two_eq, rpow_two_eq]
    have hval : opTot (H i) ((x : lp G 2) i) = H i (fib C x i) := opTot_of_mem _ (x.2.1 i)
    have hshift : (C i).op (fib C x i) + ((fib C x i : G i))
        = (dsCompOp C x : lp G 2) i + (x : lp G 2) i := by
      rw [dsCompOp_fib]
      rfl
    have hb := hrel i (fib C x i)
    rw [hshift] at hb
    rw [hval]
    calc ‖H i (fib C x i)‖ ^ 2
        ≤ (K * ‖(dsCompOp C x : lp G 2) i + (x : lp G 2) i‖) ^ 2 :=
          pow_le_pow_left₀ (norm_nonneg _) hb 2
      _ = K ^ 2 * ‖(dsCompOp C x : lp G 2) i + (x : lp G 2) i‖ ^ 2 := by ring⟩
  map_add' x y := by
    refine lp.ext (funext fun i => ?_)
    change opTot (H i) (((x + y : dsDom C) : lp G 2) i) = _
    simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    exact opTot_add _ (x.2.1 i) (y.2.1 i)
  map_smul' a x := by
    refine lp.ext (funext fun i => ?_)
    change opTot (H i) (((a • x : dsDom C) : lp G 2) i) = _
    simp only [SetLike.val_smul, lp.coeFn_smul, Pi.smul_apply, RingHom.id_apply]
    exact opTot_smul _ a (x.2.1 i)

variable {C H}

@[simp] theorem dsFibOp_fib {K : ℝ}
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (x : dsDom C) (i : ι) :
    ((dsFibOp C H K hrel x : lp G 2) : ∀ i, G i) i = H i (fib C x i) :=
  opTot_of_mem _ (x.2.1 i)

theorem dsFibOp_symmetricOn {K : ℝ}
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (hsym : ∀ i, SymmetricOn (C i).dom (H i)) :
    SymmetricOn (dsDom C) (dsFibOp C H K hrel) := by
  intro x y
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun i => ?_
  rw [dsFibOp_fib, dsFibOp_fib]
  exact hsym i (fib C x i) (fib C y i)

/-- The commutator form of the lift is the sum of the fibre commutator forms. -/
theorem dsFibOp_hasSum_commForm {K : ℝ}
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (x : dsDom C) :
    HasSum (fun i => commForm (H i) (C i).op (fib C x i))
      (commForm (dsFibOp C H K hrel) (dsCompOp C) x) := by
  set Hx := dsFibOp C H K hrel x with hHx
  set Nx := dsCompOp C x with hNx
  have h1 : HasSum (fun i => (inner ℂ ((Hx : lp G 2) i) ((Nx : lp G 2) i) : ℂ))
      (inner ℂ (Hx : lp G 2) (Nx : lp G 2)) := lp.hasSum_inner _ _
  have h2 : HasSum (fun i => (inner ℂ ((Nx : lp G 2) i) ((Hx : lp G 2) i) : ℂ))
      (inner ℂ (Nx : lp G 2) (Hx : lp G 2)) := lp.hasSum_inner _ _
  have h3 := (h1.sub h2).mul_left Complex.I
  have h4 := Complex.reCLM.hasSum h3
  have hfun : (fun i => Complex.reCLM (Complex.I *
        ((inner ℂ ((Hx : lp G 2) i) ((Nx : lp G 2) i) : ℂ)
          - (inner ℂ ((Nx : lp G 2) i) ((Hx : lp G 2) i) : ℂ))))
      = fun i => commForm (H i) (C i).op (fib C x i) := by
    funext i
    rw [Complex.reCLM_apply, commForm, hHx, hNx, dsFibOp_fib, dsCompOp_fib]
  rw [hfun] at h4
  exact h4

/-- **The Faris–Lavine commutator bound lifts, with the same constant.** -/
theorem dsFibOp_commForm_le {K c : ℝ}
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (hcomm : ∀ (i : ι) (u : (C i).dom), |commForm (H i) (C i).op u| ≤ c * quadForm (C i).op u)
    (x : dsDom C) :
    |commForm (dsFibOp C H K hrel) (dsCompOp C) x| ≤ c * quadForm (dsCompOp C) x := by
  have hs := dsFibOp_hasSum_commForm hrel x
  have hq := (dsCompOp_hasSum_quadForm C x).mul_left c
  have hle : ∀ i, commForm (H i) (C i).op (fib C x i) ≤ c * quadForm (C i).op (fib C x i) :=
    fun i => le_trans (le_abs_self _) (hcomm i (fib C x i))
  have hge : ∀ i, -(commForm (H i) (C i).op (fib C x i)) ≤ c * quadForm (C i).op (fib C x i) :=
    fun i => le_trans (neg_le_abs _) (hcomm i (fib C x i))
  have h1 := hasSum_le hle hs hq
  have h2 := hasSum_le hge hs.neg hq
  rw [abs_le]
  constructor
  · linarith
  · exact h1

/-- **Faris–Lavine on an `ℓ²`-direct sum.**  If every fibre carries a comparison operator
and a symmetric operator relatively bounded by it, with a *uniform* commutator bound, then
the direct-sum operator is essentially self-adjoint on the lifted domain — by Theorem 1 of
Faris–Lavine applied on the direct sum, with the lifted comparison operator. -/
theorem dsFibOp_essentiallySelfAdjointOn [∀ i, CompleteSpace (G i)] {K c : ℝ} (hc : 0 ≤ c)
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (hsym : ∀ i, SymmetricOn (C i).dom (H i))
    (hcomm : ∀ (i : ι) (u : (C i).dom), |commForm (H i) (C i).op u| ≤ c * quadForm (C i).op u) :
    EssentiallySelfAdjointOn (dsDom C) (dsFibOp C H K hrel) :=
  (dsComparison C).essentiallySelfAdjointOn (dsFibOp C H K hrel)
    (dsFibOp_symmetricOn hrel hsym) c hc (dsFibOp_commForm_le hrel hcomm)

end Lift

/-! ## 3. The quantum-gravity outer Fock space -/

/-- The **positive one-particle operator** `N₁ = −Δ + ‖x‖²/4` of the gravity sector, as a
densely defined positive symmetric operator on `L²(ℝᵈ)`. -/
def harmPosSym (d : ℕ) : PosSymOp (L2d d) where
  dom := polyGaussCore (d := d)
  op := harmCore
  sym := harmonicCore_symmetricOn
  pos := harmonicCore_quadForm_nonneg

/-- **The Friedrichs extension of the positive one-particle operator**, as a Faris–Lavine
comparison operator: positive, self-adjoint, and with `N₁ + 1` onto `L²(ℝᵈ)`. -/
def harmFried (d : ℕ) : Comparison (L2d d) :=
  friedrichsComparison (harmPosSym d) polyGaussCore_dense

theorem polyGaussCore_le_harmFriedDom (d : ℕ) :
    (polyGaussCore (d := d)) ≤ (harmFried d).dom := fun v hv =>
  (friedrichsComparison_extends (harmPosSym d) polyGaussCore_dense ⟨v, hv⟩).choose

/-- On the Gauss–polynomial core the Friedrichs extension is the harmonic Hamiltonian. -/
theorem harmFried_op_core (d : ℕ) (p : polyGaussCore (d := d))
    (h : (p : L2d d) ∈ (harmFried d).dom) :
    (harmFried d).op ⟨(p : L2d d), h⟩ = harmCore p :=
  (friedrichsComparison_extends (harmPosSym d) polyGaussCore_dense p).choose_spec

/-- The Friedrichs extension really is a positive self-adjoint extension of the harmonic
one-particle operator. -/
theorem harmFried_isPositiveSelfAdjointExtension (d : ℕ) :
    IsPositiveSelfAdjointExtension (harmCore (d := d)) (harmFried d).op :=
  (harmFried d).isPositiveSelfAdjointExtension harmCore
    (fun p => ⟨polyGaussCore_le_harmFriedDom d p.2, harmFried_op_core d p _⟩)

/-- **The lift of the one-particle comparison operator to the outer Fock space**: the
`ℓ²`-direct sum `⊕ₙ N₁^{(n)}` of the sector realizations of the Friedrichs extension.  It
is again positive, self-adjoint and has `𝑁 + 1` onto the whole outer Fock space, so it is
an admissible Faris–Lavine comparison operator there. -/
def qgOuterComparison : Comparison qgOuterFock :=
  dsComparison (fun n : ℕ => harmFried (n * 84))

/-- The domain of the lifted comparison operator. -/
abbrev qgOuterFriedDom : Submodule ℂ qgOuterFock := qgOuterComparison.dom

/-- The lifted comparison operator `dΓ(N₁)` on the outer Fock space. -/
abbrev qgOuterFriedN : qgOuterFriedDom →ₗ[ℂ] qgOuterFock := qgOuterComparison.op

theorem qgOuterFriedN_symmetricOn : SymmetricOn qgOuterFriedDom qgOuterFriedN :=
  qgOuterComparison.sym

theorem qgOuterFriedN_quadForm_nonneg (x : qgOuterFriedDom) : 0 ≤ quadForm qgOuterFriedN x :=
  qgOuterComparison.pos x

/-- **`𝑁 + 1` is onto the outer Fock space** — the property of the comparison operator
that the Faris–Lavine argument consumes, and the reason the lift works. -/
theorem qgOuterFriedN_surj (f : qgOuterFock) :
    ∃ x : qgOuterFriedDom, qgOuterFriedN x + (x : qgOuterFock) = f :=
  qgOuterComparison.surj f

set_option maxHeartbeats 1600000 in
-- the lifted domain is built from the Friedrichs completion, so unfolding it is costly
/-- The finite-particle core sits inside the domain of the lifted comparison operator. -/
theorem qgOuterCore_le_friedDom : qgOuterCore ≤ qgOuterFriedDom := by
  intro x hx
  refine ⟨fun n => polyGaussCore_le_harmFriedDom (n * 84) (hx.2 n), ?_⟩
  have hfun : (fun n : ℕ => opTot (harmFried (n * 84)).op ((x : qgOuterFock) n))
      = fun n : ℕ => (harmCore ⟨(x : qgOuterFock) n, hx.2 n⟩ : L2d (n * 84)) := by
    funext n
    rw [opTot_of_mem _ (polyGaussCore_le_harmFriedDom (n * 84) (hx.2 n)),
      harmFried_op_core (n * 84) ⟨(x : qgOuterFock) n, hx.2 n⟩]
  rw [hfun]
  refine memLp_of_finite_support (Set.Finite.subset hx.1 fun n hn => ?_)
  simp only [Set.mem_setOf_eq] at hn ⊢
  intro h0
  refine hn ?_
  have hz : (⟨(x : qgOuterFock) n, hx.2 n⟩ : polyGaussCore (d := n * 84)) = 0 :=
    Subtype.ext h0
  rw [hz, map_zero]

/-- The lifted comparison operator, fibrewise. -/
theorem qgOuterFriedN_apply (x : qgOuterFriedDom) (n : ℕ) :
    ((qgOuterFriedN x : qgOuterFock) : ∀ n : ℕ, L2d (n * 84)) n
      = (harmFried (n * 84)).op ⟨((x : qgOuterFock) : ∀ n : ℕ, L2d (n * 84)) n, x.2.1 n⟩ :=
  dsCompOp_fib _ x n

set_option maxHeartbeats 2000000 in
-- the Friedrichs domain is a range of a completion-built resolvent: defeq checks are costly
/-- **The lifted Friedrichs extension is a positive self-adjoint extension of the lifted
one-particle operator** `⊕ₙ dΓ(N₁)` on the finite-particle core.  This is the statement
that the Friedrichs extension of the positive one-particle operator lifts to the outer
Fock space. -/
theorem qgOuterFriedN_isPositiveSelfAdjointExtension :
    IsPositiveSelfAdjointExtension qgOuterN qgOuterFriedN :=
  qgOuterComparison.isPositiveSelfAdjointExtension qgOuterN (fun x => by
    refine ⟨qgOuterCore_le_friedDom x.2, ?_⟩
    refine lp.ext (funext fun n => ?_)
    rw [qgOuterFriedN_apply, harmFried_op_core (n * 84) ⟨(x : qgOuterFock) n, x.2.2 n⟩]
    exact (dsOp_coe (fun n : ℕ => harmCore (d := n * 84)) x n).symm)

/-- **The lifted comparison operator is essentially self-adjoint on its own domain** — the
`H = N`, `c = 0` case of the Faris–Lavine criterion. -/
theorem qgOuterFriedN_esa : EssentiallySelfAdjointOn qgOuterFriedDom qgOuterFriedN :=
  qgOuterComparison.esa_self

set_option maxHeartbeats 2000000 in
-- the Friedrichs domain is a range of a completion-built resolvent: defeq checks are costly
/-- **The full gravity Hamiltonian on the outer Fock space is essentially self-adjoint by
Faris–Lavine**, with the lifted Friedrichs extension of the positive one-particle operator
as comparison operator.

The hypotheses are the sector-level Faris–Lavine data: a realization `H n` of the
`n`-particle gravity Hamiltonian on the domain of the sector comparison operator
(`hext` says it *is* a realization: on the Gauss–polynomial core it is `qgSectorHam n`),
symmetric, relatively bounded by `N + 1` with a constant `K` uniform in the particle
number, and with the commutator bound `±i[H, N] ≤ c N` with a constant `c` uniform in the
particle number.  Uniformity in `n` is what the lift needs and all that it needs. -/
theorem qgOuterFock_esa_farisLavine
    (H : ∀ n : ℕ, (harmFried (n * 84)).dom →ₗ[ℂ] L2d (n * 84))
    (hsym : ∀ n : ℕ, SymmetricOn (harmFried (n * 84)).dom (H n))
    (hext : ∀ (n : ℕ) (p : polyGaussCore (d := n * 84))
      (h : (p : L2d (n * 84)) ∈ (harmFried (n * 84)).dom),
      H n ⟨(p : L2d (n * 84)), h⟩ = qgSectorHam n p)
    (K c : ℝ) (hc : 0 ≤ c)
    (hrel : ∀ (n : ℕ) (u : (harmFried (n * 84)).dom),
      ‖H n u‖ ≤ K * ‖(harmFried (n * 84)).op u + (u : L2d (n * 84))‖)
    (hcomm : ∀ (n : ℕ) (u : (harmFried (n * 84)).dom),
      |commForm (H n) (harmFried (n * 84)).op u| ≤ c * quadForm (harmFried (n * 84)).op u) :
    EssentiallySelfAdjointOn qgOuterFriedDom
        (dsFibOp (fun n : ℕ => harmFried (n * 84)) H K hrel) ∧
      ∀ x : qgOuterCore, ∃ h : (x : qgOuterFock) ∈ qgOuterFriedDom,
        dsFibOp (fun n : ℕ => harmFried (n * 84)) H K hrel ⟨(x : qgOuterFock), h⟩
          = qgOuterHam x := by
  refine ⟨dsFibOp_essentiallySelfAdjointOn hc hrel hsym hcomm, fun x => ?_⟩
  refine ⟨qgOuterCore_le_friedDom x.2, ?_⟩
  refine lp.ext (funext fun n => ?_)
  have hfib : ((dsFibOp (fun n : ℕ => harmFried (n * 84)) H K hrel
        ⟨(x : qgOuterFock), qgOuterCore_le_friedDom x.2⟩ : qgOuterFock)
      : ∀ n : ℕ, L2d (n * 84)) n
      = H n ⟨((x : qgOuterFock) : ∀ n : ℕ, L2d (n * 84)) n,
          polyGaussCore_le_harmFriedDom (n * 84) (x.2.2 n)⟩ :=
    dsFibOp_fib hrel _ n
  rw [hfib, hext n ⟨(x : qgOuterFock) n, x.2.2 n⟩]
  exact (dsOp_coe (fun n : ℕ => qgSectorHam n) x n).symm

end

end BookProof.QgOuterFockFL
