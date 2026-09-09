import Mathlib
import BookProof.ChapterQgOuterFockFarisLavine

/-!
# From a graph core to the whole comparison domain

Theorem 1 of Faris–Lavine, as formalized in `BookProof.ChapterFarisLavine` and packaged
with a comparison operator in `BookProof.ChapterQgOuterFockFarisLavine`, wants the
Hamiltonian `H` defined on the **whole** domain `𝒟(N)` of the comparison operator.  A
concrete Hamiltonian, however, is handed to us on a small core — for the quantum-gravity
sectors, the Gauss–polynomial core of `L²(ℝᴰ)`, which is much smaller than the Friedrichs
domain of the oscillator.  This module closes that gap once and for all.

The mechanism is the relative bound itself.  If `‖H₀u‖ ≤ K‖(N+1)u‖` on the core `C₀`, then
`H₀ ∘ (N+1)|_{C₀}⁻¹` is a **bounded** operator on the range of `(N+1)|_{C₀}`; that range is
dense (`coreRange_dense`), so the bounded operator extends continuously to the whole space
(`extCLM`), and composing back with `N + 1` on `𝒟(N)` produces the extension `ext`.  The
extension automatically satisfies the *same* relative bound (`ext_norm_le`), restricts to
`H₀` on the core (`ext_core`), and — this is the point — inherits symmetry and the
Faris–Lavine commutator bound from the core, by approximating an arbitrary domain vector
in the graph norm of `N` (`gcSeq` and the continuity lemmas around it).

The hypothesis that makes the approximation available is `IsGraphCore`: every vector of
`𝒟(N)` is approximated by core vectors *together with* their images under `N`.

## What is proved

* `shiftOp`, `shiftOp_injective` — the shift `N + 1` of a comparison operator and its
  injectivity (a consequence of positivity);
* `commForm_congr`, `quadForm_congr` — the two Faris–Lavine forms depend only on the
  values of the operators, not on the domain they are presented on;
* `IsGraphCore` — a subspace of `𝒟(N)` dense in the graph norm of `N`;
* `CoreData` — the package: a comparison operator, a graph core, a symmetric operator on
  the core, and a relative bound `‖H₀u‖ ≤ K‖(N+1)u‖`;
* `CoreData.coreRange`, `coreRange_dense`, `coreEquiv`, `resolvedMap`, `resolvedCLM`,
  `extCLM` — the bounded-extension construction;
* **`CoreData.ext`**, `ext_core`, `ext_norm_le`, `ext_symmetricOn`, `ext_commForm_le` —
  the extension of the Hamiltonian to the whole comparison domain, with the relative
  bound, symmetry and the commutator bound all transported from the core with the *same*
  constants;
* **`CoreData.ext_essentiallySelfAdjointOn`** — Faris–Lavine for the extension: the
  Hamiltonian extended from a graph core is essentially self-adjoint on `𝒟(N)`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgOuterFockCoreFL

open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.QgOuterFockFL
open BookProof.YangMillsFriedrichs
open BookProof.EsaClosure
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore
open Filter Topology

noncomputable section

/-! ## 1. Extending a relatively bounded operator from a graph core -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- The shift `N + 1` of a comparison operator. -/
def shiftOp (C : Comparison F) : C.dom →ₗ[ℂ] F := C.op + C.dom.subtype

omit [CompleteSpace F] in
@[simp] theorem shiftOp_apply (C : Comparison F) (x : C.dom) :
    shiftOp C x = C.op x + (x : F) := rfl

omit [CompleteSpace F] in
/-- `commForm` depends only on the values `H x`, `N x`. -/
theorem commForm_congr {D D' : Submodule ℂ F} (H N : D →ₗ[ℂ] F) (H' N' : D' →ₗ[ℂ] F)
    (x : D) (x' : D') (hH : H x = H' x') (hN : N x = N' x') :
    commForm H N x = commForm H' N' x' := by
  unfold commForm
  rw [hH, hN]

omit [CompleteSpace F] in
/-- `quadForm` depends only on the values `x`, `N x`. -/
theorem quadForm_congr {D D' : Submodule ℂ F} (N : D →ₗ[ℂ] F) (N' : D' →ₗ[ℂ] F)
    (x : D) (x' : D') (hx : (x : F) = (x' : F)) (hN : N x = N' x') :
    quadForm N x = quadForm N' x' := by
  unfold quadForm
  rw [hx, hN]

omit [CompleteSpace F] in
theorem shiftOp_injective (C : Comparison F) : Function.Injective (shiftOp C) := by
  intro a b hab
  have hz : shiftOp C (a - b) = 0 := by rw [map_sub, hab, sub_self]
  have h := norm_le_norm_shift C.op C.pos (a - b)
  rw [← shiftOp_apply, hz, norm_zero] at h
  have h0 : ((a - b : C.dom) : F) = 0 := by
    have := norm_nonneg ((a - b : C.dom) : F)
    exact norm_le_zero_iff.mp h
  exact sub_eq_zero.mp (Subtype.ext (by simpa using h0))

/-- `C₀` is a **graph core** for the comparison operator `C`: it sits inside the domain and
every domain vector is approximated by a core vector simultaneously in the norm of `F` and
in the norm of its image under `N`. -/
structure IsGraphCore (C : Comparison F) (C₀ : Submodule ℂ F) : Prop where
  /-- The core sits inside the domain. -/
  le : C₀ ≤ C.dom
  /-- Approximation in the graph norm. -/
  approx : ∀ (x : C.dom) (ε : ℝ), 0 < ε → ∃ y : C.dom, (y : F) ∈ C₀ ∧
    ‖(y : F) - (x : F)‖ < ε ∧ ‖C.op y - C.op x‖ < ε

/-- The data needed to extend a symmetric operator from a graph core to the whole domain of
a comparison operator: a relative bound with respect to `N + 1`. -/
structure CoreData (F : Type*) [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    [CompleteSpace F] where
  /-- The comparison operator. -/
  C : Comparison F
  /-- The graph core. -/
  C₀ : Submodule ℂ F
  /-- The core is a graph core. -/
  gc : IsGraphCore C C₀
  /-- The operator, defined on the core only. -/
  H₀ : C₀ →ₗ[ℂ] F
  /-- The relative bound constant. -/
  K : ℝ
  /-- The relative bound constant is nonnegative. -/
  hK : 0 ≤ K
  /-- The relative bound `‖H₀ p‖ ≤ K‖(N + 1)p‖` on the core. -/
  rel : ∀ p : C₀, ‖H₀ p‖ ≤ K * ‖C.op ⟨(p : F), gc.le p.2⟩ + (p : F)‖

namespace CoreData

variable (d : CoreData F)

/-- The comparison operator restricted to the core. -/
def coreN : d.C₀ →ₗ[ℂ] F := d.C.op.comp (Submodule.inclusion d.gc.le)

@[simp] theorem coreN_apply (p : d.C₀) :
    d.coreN p = d.C.op ⟨(p : F), d.gc.le p.2⟩ := rfl

/-- The shift `N + 1` restricted to the core. -/
def coreShift : d.C₀ →ₗ[ℂ] F := (shiftOp d.C).comp (Submodule.inclusion d.gc.le)

@[simp] theorem coreShift_apply (p : d.C₀) :
    d.coreShift p = d.C.op ⟨(p : F), d.gc.le p.2⟩ + (p : F) := rfl

theorem coreShift_injective : Function.Injective d.coreShift := by
  intro a b hab
  have h1 : (Submodule.inclusion d.gc.le) a = (Submodule.inclusion d.gc.le) b :=
    shiftOp_injective d.C hab
  have h2 : (a : F) = (b : F) := by
    simpa using congrArg (fun z : d.C.dom => (z : F)) h1
  exact Subtype.ext h2

/-- The image of the core under `N + 1`. -/
def coreRange : Submodule ℂ F := LinearMap.range d.coreShift

theorem coreRange_dense : Dense ((d.coreRange : Submodule ℂ F) : Set F) := by
  rw [Metric.dense_iff]
  intro f r hr
  obtain ⟨x, hx⟩ := d.C.surj f
  obtain ⟨y, hyC, hy1, hy2⟩ := d.gc.approx x (r / 3) (by positivity)
  refine ⟨d.coreShift ⟨(y : F), hyC⟩, ?_, ⟨⟨(y : F), hyC⟩, rfl⟩⟩
  have hyy : (⟨(y : F), d.gc.le hyC⟩ : d.C.dom) = y := Subtype.ext rfl
  have hval : d.coreShift ⟨(y : F), hyC⟩ = d.C.op y + (y : F) := by
    rw [coreShift_apply, hyy]
  rw [Metric.mem_ball, dist_eq_norm, hval, ← hx]
  calc ‖d.C.op y + (y : F) - (d.C.op x + (x : F))‖
      = ‖(d.C.op y - d.C.op x) + ((y : F) - (x : F))‖ := by congr 1; abel
    _ ≤ ‖d.C.op y - d.C.op x‖ + ‖(y : F) - (x : F)‖ := norm_add_le _ _
    _ < r / 3 + r / 3 := by linarith
    _ < r := by linarith

theorem coreRange_denseRange : DenseRange (d.coreRange.subtypeL) := by
  have : Set.range (d.coreRange.subtypeL) = (d.coreRange : Set F) := Subtype.range_coe
  rw [DenseRange, this]
  exact d.coreRange_dense

theorem coreRange_isUniformInducing : IsUniformInducing (d.coreRange.subtypeL) :=
  (isometry_subtype_coe (s := (d.coreRange : Set F))).isUniformInducing

/-- The core, identified with its image under `N + 1`. -/
def coreEquiv : d.C₀ ≃ₗ[ℂ] d.coreRange :=
  LinearEquiv.ofInjective _ d.coreShift_injective

@[simp] theorem coreEquiv_coe (p : d.C₀) : ((d.coreEquiv p : d.coreRange) : F) = d.coreShift p :=
  rfl

/-- `H₀ ∘ (N+1)⁻¹` on the image of the core: a *bounded* operator, by the relative bound. -/
def resolvedMap : d.coreRange →ₗ[ℂ] F := d.H₀.comp d.coreEquiv.symm.toLinearMap

theorem resolvedMap_bound (w : d.coreRange) : ‖d.resolvedMap w‖ ≤ d.K * ‖(w : F)‖ := by
  have h := d.rel (d.coreEquiv.symm w)
  have hw : d.coreShift (d.coreEquiv.symm w) = (w : F) := by
    rw [← coreEquiv_coe, LinearEquiv.apply_symm_apply]
  rw [← coreShift_apply, hw] at h
  exact h

/-- The bounded operator `H₀ ∘ (N+1)⁻¹`, on the dense subspace `(N+1)C₀`. -/
def resolvedCLM : d.coreRange →L[ℂ] F := d.resolvedMap.mkContinuous d.K d.resolvedMap_bound

theorem norm_resolvedCLM_le : ‖d.resolvedCLM‖ ≤ d.K :=
  LinearMap.mkContinuous_norm_le _ d.hK _

/-- Its extension to the whole space, by density. -/
def extCLM : F →L[ℂ] F := d.resolvedCLM.extend d.coreRange.subtypeL

theorem norm_extCLM_le : ‖d.extCLM‖ ≤ d.K := by
  have h : ‖d.extCLM‖ ≤ ((1 : NNReal) : ℝ) * ‖d.resolvedCLM‖ :=
    ContinuousLinearMap.opNorm_extend_le (N := 1) _ d.coreRange_denseRange (fun x => by simp)
  simp only [NNReal.coe_one, one_mul] at h
  exact h.trans d.norm_resolvedCLM_le

/-- **The extension of `H₀` from the graph core to the whole comparison domain.** -/
def ext : d.C.dom →ₗ[ℂ] F := (d.extCLM : F →ₗ[ℂ] F).comp (shiftOp d.C)

theorem ext_apply (x : d.C.dom) : d.ext x = d.extCLM (d.C.op x + (x : F)) := rfl

/-- On the core the extension is the original operator. -/
theorem ext_core (p : d.C₀) : d.ext ⟨(p : F), d.gc.le p.2⟩ = d.H₀ p := by
  have hext := ContinuousLinearMap.extend_eq d.resolvedCLM d.coreRange_denseRange
    d.coreRange_isUniformInducing (d.coreEquiv p)
  calc d.ext ⟨(p : F), d.gc.le p.2⟩
      = (d.resolvedCLM.extend d.coreRange.subtypeL)
          (d.coreRange.subtypeL (d.coreEquiv p)) := rfl
    _ = d.resolvedCLM (d.coreEquiv p) := hext
    _ = d.H₀ p := by simp [resolvedCLM, resolvedMap]

/-- The extension satisfies the same relative bound on the whole domain. -/
theorem ext_norm_le (x : d.C.dom) : ‖d.ext x‖ ≤ d.K * ‖d.C.op x + (x : F)‖ := by
  rw [ext_apply]
  calc ‖d.extCLM (d.C.op x + (x : F))‖ ≤ ‖d.extCLM‖ * ‖d.C.op x + (x : F)‖ :=
        d.extCLM.le_opNorm _
    _ ≤ d.K * ‖d.C.op x + (x : F)‖ :=
        mul_le_mul_of_nonneg_right d.norm_extCLM_le (norm_nonneg _)

/-! ### Graph-core approximating sequences -/

/-- A sequence in the core converging to `x` in the graph norm. -/
def gcSeq (x : d.C.dom) (k : ℕ) : d.C.dom :=
  (d.gc.approx x (1 / (k + 1)) (by positivity)).choose

theorem gcSeq_mem (x : d.C.dom) (k : ℕ) : ((d.gcSeq x k : d.C.dom) : F) ∈ d.C₀ :=
  (d.gc.approx x (1 / (k + 1)) (by positivity)).choose_spec.1

theorem gcSeq_norm_lt (x : d.C.dom) (k : ℕ) :
    ‖((d.gcSeq x k : d.C.dom) : F) - (x : F)‖ < 1 / (k + 1) :=
  (d.gc.approx x (1 / (k + 1)) (by positivity)).choose_spec.2.1

theorem gcSeq_op_norm_lt (x : d.C.dom) (k : ℕ) :
    ‖d.C.op (d.gcSeq x k) - d.C.op x‖ < 1 / (k + 1) :=
  (d.gc.approx x (1 / (k + 1)) (by positivity)).choose_spec.2.2

theorem tendsto_inv_succ : Tendsto (fun k : ℕ => 1 / ((k : ℝ) + 1)) atTop (𝓝 0) :=
  tendsto_one_div_add_atTop_nhds_zero_nat (𝕜 := ℝ)

theorem gcSeq_tendsto (x : d.C.dom) :
    Tendsto (fun k => ((d.gcSeq x k : d.C.dom) : F)) atTop (𝓝 (x : F)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  refine squeeze_zero (fun k => norm_nonneg _) (fun k => (d.gcSeq_norm_lt x k).le)
    tendsto_inv_succ

theorem gcSeq_op_tendsto (x : d.C.dom) :
    Tendsto (fun k => d.C.op (d.gcSeq x k)) atTop (𝓝 (d.C.op x)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  refine squeeze_zero (fun k => norm_nonneg _) (fun k => (d.gcSeq_op_norm_lt x k).le)
    tendsto_inv_succ

theorem gcSeq_ext_tendsto (x : d.C.dom) :
    Tendsto (fun k => d.ext (d.gcSeq x k)) atTop (𝓝 (d.ext x)) := by
  have hs : Tendsto (fun k => d.C.op (d.gcSeq x k) + ((d.gcSeq x k : d.C.dom) : F)) atTop
      (𝓝 (d.C.op x + (x : F))) := (d.gcSeq_op_tendsto x).add (d.gcSeq_tendsto x)
  simpa only [ext_apply] using (d.extCLM.continuous.tendsto _).comp hs

theorem ext_gcSeq (x : d.C.dom) (k : ℕ) :
    d.ext (d.gcSeq x k) = d.H₀ ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩ := by
  have := d.ext_core ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩
  rw [← this]

theorem coreN_gcSeq (x : d.C.dom) (k : ℕ) :
    d.coreN ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩ = d.C.op (d.gcSeq x k) := by
  rw [coreN_apply]

/-! ### The extension inherits symmetry and the commutator bound -/

theorem ext_symmetricOn (hsym : SymmetricOn d.C₀ d.H₀) : SymmetricOn d.C.dom d.ext := by
  intro x z
  have hl : Tendsto (fun k => (inner ℂ (d.ext (d.gcSeq x k))
      ((d.gcSeq z k : d.C.dom) : F) : ℂ)) atTop (𝓝 (inner ℂ (d.ext x) (z : F))) :=
    (d.gcSeq_ext_tendsto x).inner (d.gcSeq_tendsto z)
  have hr : Tendsto (fun k => (inner ℂ ((d.gcSeq x k : d.C.dom) : F)
      (d.ext (d.gcSeq z k)) : ℂ)) atTop (𝓝 (inner ℂ (x : F) (d.ext z))) :=
    (d.gcSeq_tendsto x).inner (d.gcSeq_ext_tendsto z)
  have heq : ∀ k, (inner ℂ (d.ext (d.gcSeq x k)) ((d.gcSeq z k : d.C.dom) : F) : ℂ)
      = inner ℂ ((d.gcSeq x k : d.C.dom) : F) (d.ext (d.gcSeq z k)) := by
    intro k
    rw [d.ext_gcSeq x k, d.ext_gcSeq z k]
    exact hsym ⟨_, d.gcSeq_mem x k⟩ ⟨_, d.gcSeq_mem z k⟩
  exact tendsto_nhds_unique (by simpa only [heq] using hl) hr

theorem ext_commForm_tendsto (x : d.C.dom) :
    Tendsto (fun k => commForm d.ext d.C.op (d.gcSeq x k)) atTop
      (𝓝 (commForm d.ext d.C.op x)) := by
  have h1 : Tendsto (fun k => (inner ℂ (d.ext (d.gcSeq x k)) (d.C.op (d.gcSeq x k)) : ℂ))
      atTop (𝓝 (inner ℂ (d.ext x) (d.C.op x))) :=
    (d.gcSeq_ext_tendsto x).inner (d.gcSeq_op_tendsto x)
  have h2 : Tendsto (fun k => (inner ℂ (d.C.op (d.gcSeq x k)) (d.ext (d.gcSeq x k)) : ℂ))
      atTop (𝓝 (inner ℂ (d.C.op x) (d.ext x))) :=
    (d.gcSeq_op_tendsto x).inner (d.gcSeq_ext_tendsto x)
  simpa only [commForm] using (Complex.reCLM.continuous.tendsto _).comp
    (((h1.sub h2).const_mul Complex.I))

theorem quadForm_tendsto (x : d.C.dom) :
    Tendsto (fun k => quadForm d.C.op (d.gcSeq x k)) atTop (𝓝 (quadForm d.C.op x)) := by
  have h1 : Tendsto (fun k => (inner ℂ ((d.gcSeq x k : d.C.dom) : F)
      (d.C.op (d.gcSeq x k)) : ℂ)) atTop (𝓝 (inner ℂ (x : F) (d.C.op x))) :=
    (d.gcSeq_tendsto x).inner (d.gcSeq_op_tendsto x)
  simpa only [quadForm] using (Complex.reCLM.continuous.tendsto _).comp h1

theorem ext_commForm_le {c : ℝ}
    (hcomm : ∀ p : d.C₀, |commForm d.H₀ d.coreN p| ≤ c * quadForm d.coreN p)
    (x : d.C.dom) : |commForm d.ext d.C.op x| ≤ c * quadForm d.C.op x := by
  have hstep : ∀ k, |commForm d.ext d.C.op (d.gcSeq x k)|
      ≤ c * quadForm d.C.op (d.gcSeq x k) := by
    intro k
    have h := hcomm ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩
    have hc1 : commForm d.ext d.C.op (d.gcSeq x k)
        = commForm d.H₀ d.coreN ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩ :=
      commForm_congr _ _ _ _ _ _ (d.ext_gcSeq x k) (d.coreN_gcSeq x k).symm
    have hc2 : quadForm d.C.op (d.gcSeq x k)
        = quadForm d.coreN ⟨((d.gcSeq x k : d.C.dom) : F), d.gcSeq_mem x k⟩ :=
      quadForm_congr _ _ _ _ rfl (d.coreN_gcSeq x k).symm
    rw [hc1, hc2]
    exact h
  exact le_of_tendsto_of_tendsto ((d.ext_commForm_tendsto x).abs)
    ((d.quadForm_tendsto x).const_mul c) (Eventually.of_forall hstep)

/-- **Faris–Lavine from core data.**  If a symmetric operator on a graph core of a
comparison operator is relatively bounded by `N + 1` and satisfies the Faris–Lavine
commutator bound *on the core*, then its extension to the whole domain of `N` is
essentially self-adjoint there. -/
theorem ext_essentiallySelfAdjointOn (hsym : SymmetricOn d.C₀ d.H₀) {c : ℝ} (hc : 0 ≤ c)
    (hcomm : ∀ p : d.C₀, |commForm d.H₀ d.coreN p| ≤ c * quadForm d.coreN p) :
    EssentiallySelfAdjointOn d.C.dom d.ext :=
  d.C.essentiallySelfAdjointOn d.ext (d.ext_symmetricOn hsym) c hc (d.ext_commForm_le hcomm)

end CoreData

end Abstract

end

end BookProof.QgOuterFockCoreFL
