import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA1
import BookProof.ChapterA1c
import BookProof.ChapterA2
import BookProof.ChapterA2b

/-!
# Chapter A, §A.2 — the commutant classification, R-complex and R-pseudoreal cases
(work-package N2 residue)

This file continues work-package **N2** of `FORMALIZATION_ROADMAP.md` (§A.2, the
commutant classification ℝ / ℂ / ℍ).  `ChapterA2b.lean` established **Prop 17**
(the R-real commutant is `ℝ`).  Here we formalize the remaining two entries of
the trichotomy:

* **Prop 18 (R-complex commutant `≅ ℂ`)** and
* **Prop 19 (R-pseudoreal commutant `≅ ℍ`)**.

## The setup

For a complex system `(M, V)` we work with the **real commutant** — the
continuous **`ℝ`-linear** operators on `V` commuting with every `m ∈ M`
(`RealCommutes`).  Two canonical real operators live inside it:

* `mulI` — multiplication by `i` (`ℂ`-linear, hence always commutes with `M`),
  with `mulI * mulI = -1`;
* `thetaR θ` — the real-linear operator underlying a commuting anti-unitary `θ`
  (conjugate-linear), which commutes with `M` exactly when `θ` does.

Since `mulI * mulI = -1`, the pair `(ℝ, mulI)` gives an `ℝ`-algebra embedding
`ℂ →ₐ[ℝ] (V →L[ℝ] V)` (`cembed`).  When additionally `θ² = -1` (the
R-pseudoreal / quaternionic anti-unitary), the triple `mulI, thetaR θ,
mulI·thetaR θ` satisfies the quaternion relations `i² = j² = -1`, `ij = -ji`,
giving an `ℝ`-algebra embedding `ℍ →ₐ[ℝ] (V →L[ℝ] V)` (`qembed`).

The classification results say these embeddings are **onto the real commutant**:

* Prop 18: if the linear commutant is `ℂ` (`IsSchurFull`) and there is **no**
  nonzero commuting `ℂ`-antilinear operator (`NoAntilinearCommutant`, the precise
  algebraic content of C-complex), then the real commutant is exactly the image
  of `cembed`, i.e. `≅ ℂ`.
* Prop 19: if the linear commutant is `ℂ` (`IsSchurFull`) and `θ` is a commuting
  anti-unitary with `θ² = -1`, then the real commutant is exactly the image of
  `qembed`, i.e. `≅ ℍ` (the antilinear part is `ℂ·θ` by the Schur argument, so the
  four generators `1, i, θ, iθ` span the commutant).

The engine of both reverse inclusions is the **linear/antilinear decomposition**
of a real-linear operator `S = Plin S + Qanti S`, where `Plin S` commutes with
`mulI` (so is `ℂ`-linear, hence a scalar by `IsSchurFull`) and `Qanti S`
anticommutes with `mulI` (so is `ℂ`-antilinear).

Schur's lemma for the representation (flagged `EXTERNAL` for unitary reps by the
roadmap) enters only through the named hypothesis `IsSchurFull` (see
`ChapterA2b.lean`), never as an `axiom`.
-/

open scoped ComplexConjugate InnerProductSpace Quaternion

namespace BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

/-! ## Real-linear incarnations of `i` and of an anti-unitary -/

/-- The real-linear continuous operator underlying a conjugate-linear continuous
map. -/
noncomputable def toRealCLM (f : V →SL[starRingEnd ℂ] V) : V →L[ℝ] V where
  toLinearMap :=
  { toFun := f
    map_add' := f.map_add
    map_smul' := by
      intro r x
      simp only [RingHom.id_apply]
      have := f.map_smulₛₗ (r : ℂ) x
      simpa [Complex.coe_smul, Complex.conj_ofReal] using this }
  cont := f.continuous

omit [CompleteSpace V] in
@[simp] lemma toRealCLM_apply (f : V →SL[starRingEnd ℂ] V) (x : V) :
    toRealCLM f x = f x := rfl

/-- The real-linear operator underlying an anti-unitary `θ`. -/
noncomputable def thetaR (θ : AntiUnitary V) : V →L[ℝ] V :=
  toRealCLM (θ.toContinuousLinearEquiv.toContinuousLinearMap)

omit [CompleteSpace V] in
@[simp] lemma thetaR_apply (θ : AntiUnitary V) (x : V) : thetaR θ x = θ x := rfl

/-- Multiplication by `i`, as a real-linear continuous operator. -/
noncomputable def mulI : V →L[ℝ] V :=
  ContinuousLinearMap.restrictScalars ℝ ((Complex.I : ℂ) • (1 : V →L[ℂ] V))

omit [CompleteSpace V] in
@[simp] lemma mulI_apply (x : V) : (mulI : V →L[ℝ] V) x = (Complex.I : ℂ) • x := rfl

omit [CompleteSpace V] in
lemma mulI_mul_mulI : (mulI : V →L[ℝ] V) * mulI = -1 := by
  ext x
  simp only [ContinuousLinearMap.mul_apply, mulI_apply, ContinuousLinearMap.neg_apply,
    ContinuousLinearMap.one_apply]
  rw [smul_smul, Complex.I_mul_I, neg_one_smul]

/-! ## The real commutant -/

/-- An `ℝ`-linear operator `S` **commutes with** the complex system `M` iff it
commutes with every `m ∈ M` (as functions).  This is the *real commutant*. -/
def RealCommutes (M : System ℂ V) (S : V →L[ℝ] V) : Prop :=
  ∀ m ∈ M.ops, ∀ x, S (m x) = m (S x)

lemma realCommutes_one (M : System ℂ V) : RealCommutes M 1 := by
  intro m _ x; simp

lemma realCommutes_add {M : System ℂ V} {S T : V →L[ℝ] V}
    (hS : RealCommutes M S) (hT : RealCommutes M T) : RealCommutes M (S + T) := by
  intro m hm x
  simp only [ContinuousLinearMap.add_apply, map_add, hS m hm x, hT m hm x]

lemma realCommutes_mul {M : System ℂ V} {S T : V →L[ℝ] V}
    (hS : RealCommutes M S) (hT : RealCommutes M T) : RealCommutes M (S * T) := by
  intro m hm x
  simp only [ContinuousLinearMap.mul_apply]
  rw [hT m hm x, hS m hm (T x)]

lemma realCommutes_smul {M : System ℂ V} {S : V →L[ℝ] V} (hS : RealCommutes M S)
    (r : ℝ) : RealCommutes M (r • S) := by
  intro m hm x
  simp only [ContinuousLinearMap.smul_apply]
  rw [hS m hm x]
  exact (ContinuousLinearMap.map_smul_of_tower m r (S x)).symm

lemma realCommutes_neg {M : System ℂ V} {S : V →L[ℝ] V} (hS : RealCommutes M S) :
    RealCommutes M (-S) := by
  intro m hm x
  simp only [ContinuousLinearMap.neg_apply, map_neg, hS m hm x]

lemma realCommutes_algebraMap (M : System ℂ V) (r : ℝ) :
    RealCommutes M (algebraMap ℝ (V →L[ℝ] V) r) := by
  rw [Algebra.algebraMap_eq_smul_one]
  exact realCommutes_smul (realCommutes_one M) r

/-- `mulI` (multiplication by `i`) always commutes with `M` (each `m` is
`ℂ`-linear). -/
lemma realCommutes_mulI (M : System ℂ V) : RealCommutes M (mulI : V →L[ℝ] V) := by
  intro m _ x
  simp only [mulI_apply]
  rw [map_smul]

/-- `thetaR θ` commutes with `M` exactly when the anti-unitary `θ` does. -/
lemma realCommutes_thetaR {M : System ℂ V} {θ : AntiUnitary V}
    (hθ : CommutesAntiUnitary M θ) : RealCommutes M (thetaR θ) := by
  intro m hm x
  simp only [thetaR_apply]
  exact hθ m hm x

/-! ## Prop 18 (partial) — the `ℂ`-embedding into the real commutant -/

/-- The `ℝ`-algebra embedding `ℂ →ₐ[ℝ] (V →L[ℝ] V)` determined by
`i ↦ mulI` (`mulI² = -1`).  Its image is the `ℝ`-span of `1` and `mulI`, i.e. the
complex scalars viewed as real operators. -/
noncomputable def cembed : ℂ →ₐ[ℝ] (V →L[ℝ] V) :=
  Complex.lift ⟨mulI, mulI_mul_mulI⟩

omit [CompleteSpace V] in
@[simp] lemma cembed_I : cembed (Complex.I : ℂ) = (mulI : V →L[ℝ] V) := by
  rw [cembed, Complex.lift_apply, Complex.liftAux_apply]; simp

omit [CompleteSpace V] in
lemma cembed_apply (c : ℂ) (x : V) : (cembed c : V →L[ℝ] V) x = c • x := by
  rw [cembed, Complex.lift_apply, Complex.liftAux_apply]
  simp only [ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
    Algebra.algebraMap_eq_smul_one, ContinuousLinearMap.one_apply, mulI_apply]
  rw [← Complex.coe_smul, ← Complex.coe_smul, smul_smul, ← add_smul, Complex.re_add_im]

/-- The complex scalars (image of `cembed`) commute with `M`. -/
lemma cembed_realCommutes (M : System ℂ V) (c : ℂ) :
    RealCommutes M (cembed c) := by
  intro m hm x
  rw [cembed_apply, cembed_apply, map_smul]

omit [CompleteSpace V] in
lemma cembed_injective [Nontrivial V] :
    Function.Injective (cembed : ℂ → (V →L[ℝ] V)) :=
  (cembed : ℂ →ₐ[ℝ] (V →L[ℝ] V)).toRingHom.injective

/-! ## Prop 19 (partial) — the `ℍ`-embedding into the real commutant -/

/-- The quaternion basis `(i, j, k) = (mulI, thetaR θ, mulI·thetaR θ)` on the
real operator algebra, valid when `θ² = -1`.  Verifies `i² = -1`, `j² = -1`,
`ij = k`, `ji = -k`. -/
noncomputable def qbasis (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = -x) :
    QuaternionAlgebra.Basis (V →L[ℝ] V) (-1 : ℝ) (0 : ℝ) (-1 : ℝ) where
  i := mulI
  j := thetaR θ
  k := mulI * thetaR θ
  i_mul_i := by ext x; simp [ContinuousLinearMap.mul_apply, smul_smul, Complex.I_mul_I]
  j_mul_j := by ext x; simp [ContinuousLinearMap.mul_apply, hθ]
  i_mul_j := rfl
  j_mul_i := by
    ext x
    simp only [ContinuousLinearMap.mul_apply, thetaR_apply, mulI_apply]
    rw [θ.map_smulₛₗ]; simp

/-- The `ℝ`-algebra embedding `ℍ →ₐ[ℝ] (V →L[ℝ] V)` for an R-pseudoreal
anti-unitary `θ` (`θ² = -1`), sending `i, j, k` to `mulI, thetaR θ,
mulI·thetaR θ`. -/
noncomputable def qembed (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = -x) :
    (Quaternion ℝ) →ₐ[ℝ] (V →L[ℝ] V) :=
  QuaternionAlgebra.lift (qbasis θ hθ)

omit [CompleteSpace V] in
lemma qembed_apply (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = -x) (q : Quaternion ℝ) :
    qembed θ hθ q
      = algebraMap ℝ (V →L[ℝ] V) q.re + q.imI • mulI + q.imJ • thetaR θ
        + q.imK • (mulI * thetaR θ) := rfl

/-- The image of `qembed` (the real `ℝ`-span of `1, mulI, thetaR θ,
mulI·thetaR θ`) lies in the real commutant, provided `θ` commutes with `M`. -/
lemma qembed_realCommutes {M : System ℂ V} {θ : AntiUnitary V} (hθ : ∀ x, θ (θ x) = -x)
    (hθc : CommutesAntiUnitary M θ) (q : Quaternion ℝ) :
    RealCommutes M (qembed θ hθ q) := by
  rw [qembed_apply]
  have hi : RealCommutes M (mulI : V →L[ℝ] V) := realCommutes_mulI M
  have hj : RealCommutes M (thetaR θ) := realCommutes_thetaR hθc
  have hk : RealCommutes M (mulI * thetaR θ) := realCommutes_mul hi hj
  exact realCommutes_add
    (realCommutes_add
      (realCommutes_add (realCommutes_algebraMap M q.re) (realCommutes_smul hi q.imI))
      (realCommutes_smul hj q.imJ))
    (realCommutes_smul hk q.imK)

omit [CompleteSpace V] in
/-- **`qembed` is injective** (given `V` nontrivial): the quaternions embed into
the real operator algebra.  Since `ℍ` is a division ring, any algebra hom to a
nontrivial ring is injective. -/
lemma qembed_injective [Nontrivial V] (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = -x) :
    Function.Injective (qembed θ hθ) := by
  rw [injective_iff_map_eq_zero]
  intro a ha
  by_contra h
  have h1 : (qembed θ hθ) (a⁻¹ * a) = 1 := by
    rw [inv_mul_cancel₀ h]; exact map_one _
  rw [map_mul, ha, mul_zero] at h1
  exact one_ne_zero h1.symm

/-! ## The linear / antilinear decomposition -/

/-- A real-linear operator commuting with `mulI` is complex-linear. -/
noncomputable def cplxify (T : V →L[ℝ] V)
    (hT : ∀ x, T (Complex.I • x) = Complex.I • T x) : V →L[ℂ] V where
  toLinearMap :=
  { toFun := T
    map_add' := T.map_add
    map_smul' := by
      intro c x
      simp only [RingHom.id_apply]
      have hre : ∀ (r : ℝ) (y : V), T ((r : ℂ) • y) = (r : ℂ) • T y := by
        intro r y
        have := T.map_smul r y
        simp only [Complex.coe_smul]; exact this
      calc T (c • x) = T (((c.re : ℂ) + (c.im : ℂ) * Complex.I) • x) := by
                        rw [Complex.re_add_im]
        _ = (c.re : ℂ) • T x + (c.im : ℂ) • (Complex.I • T x) := by
                        rw [add_smul, mul_smul, map_add, hre, hre, hT]
        _ = c • T x := by rw [smul_smul, ← add_smul, Complex.re_add_im] }
  cont := T.continuous

omit [CompleteSpace V] in
@[simp] lemma cplxify_apply (T : V →L[ℝ] V)
    (hT : ∀ x, T (Complex.I • x) = Complex.I • T x) (x : V) : cplxify T hT x = T x := rfl

/-- If a real-linear operator commuting with `mulI` also commutes with `M`, then
its complexification lies in the (complex) commutant. -/
lemma cplxify_commutes {M : System ℂ V} {T : V →L[ℝ] V}
    (hT : ∀ x, T (Complex.I • x) = Complex.I • T x) (hTc : RealCommutes M T) :
    M.Commutes (cplxify T hT) := by
  intro m hm
  ext x
  simp only [ContinuousLinearMap.mul_apply, cplxify_apply]
  exact hTc m hm x

/-- The `ℂ`-linear part of a real-linear operator. -/
noncomputable def Plin (S : V →L[ℝ] V) : V →L[ℝ] V :=
  (2⁻¹ : ℝ) • (S - mulI * S * mulI)

/-- The `ℂ`-antilinear part of a real-linear operator. -/
noncomputable def Qanti (S : V →L[ℝ] V) : V →L[ℝ] V :=
  (2⁻¹ : ℝ) • (S + mulI * S * mulI)

omit [CompleteSpace V] in
lemma Plin_add_Qanti (S : V →L[ℝ] V) : Plin S + Qanti S = S := by
  simp only [Plin, Qanti, smul_add, smul_sub]
  abel_nf
  module

omit [CompleteSpace V] in
/-- `Plin S` commutes with `mulI` as operators (it is the complex-linear part). -/
lemma Plin_mulI_comm (S : V →L[ℝ] V) : mulI * Plin S = Plin S * mulI := by
  have h : (mulI : V →L[ℝ] V) * mulI = -1 := mulI_mul_mulI
  have e1 : (mulI : V →L[ℝ] V) * (mulI * S * mulI) = -(S * mulI) := by
    rw [← mul_assoc, ← mul_assoc, h, neg_one_mul, neg_mul]
  have e2 : (mulI * S * mulI) * (mulI : V →L[ℝ] V) = -(mulI * S) := by
    rw [mul_assoc, h, mul_neg_one]
  simp only [Plin, mul_smul_comm, smul_mul_assoc]
  congr 1
  rw [mul_sub, sub_mul, e1, e2, sub_neg_eq_add, sub_neg_eq_add, add_comm]

omit [CompleteSpace V] in
/-- `Qanti S` anticommutes with `mulI` as operators (it is the antilinear part). -/
lemma Qanti_mulI_comm (S : V →L[ℝ] V) : mulI * Qanti S = -(Qanti S * mulI) := by
  have h : (mulI : V →L[ℝ] V) * mulI = -1 := mulI_mul_mulI
  have e1 : (mulI : V →L[ℝ] V) * (mulI * S * mulI) = -(S * mulI) := by
    rw [← mul_assoc, ← mul_assoc, h, neg_one_mul, neg_mul]
  have e2 : (mulI * S * mulI) * (mulI : V →L[ℝ] V) = -(mulI * S) := by
    rw [mul_assoc, h, mul_neg_one]
  simp only [Qanti, mul_smul_comm, smul_mul_assoc, mul_add, add_mul, e1, e2]
  simp only [smul_add, smul_neg]; abel

omit [CompleteSpace V] in
/-- `Plin S` commutes with `mulI` (it is the complex-linear part). -/
lemma Plin_commutes_mulI (S : V →L[ℝ] V) (x : V) :
    Plin S (Complex.I • x) = Complex.I • Plin S x := by
  have := congr_arg (fun T => T x) (Plin_mulI_comm S)
  simpa [ContinuousLinearMap.mul_apply] using this.symm

omit [CompleteSpace V] in
/-- `Qanti S` anticommutes with `mulI` (it is the complex-antilinear part). -/
lemma Qanti_anticommutes_mulI (S : V →L[ℝ] V) (x : V) :
    Qanti S (Complex.I • x) = -(Complex.I • Qanti S x) := by
  have h2 := congr_arg (fun T => T x) (Qanti_mulI_comm S)
  simp only [ContinuousLinearMap.mul_apply, ContinuousLinearMap.neg_apply, mulI_apply] at h2
  rw [h2, neg_neg]

lemma Plin_realCommutes {M : System ℂ V} {S : V →L[ℝ] V} (hS : RealCommutes M S) :
    RealCommutes M (Plin S) := by
  refine realCommutes_smul ?_ _
  rw [sub_eq_add_neg]
  exact realCommutes_add hS
    (realCommutes_neg
      (realCommutes_mul (realCommutes_mul (realCommutes_mulI M) hS) (realCommutes_mulI M)))

lemma Qanti_realCommutes {M : System ℂ V} {S : V →L[ℝ] V} (hS : RealCommutes M S) :
    RealCommutes M (Qanti S) := by
  refine realCommutes_smul ?_ _
  exact realCommutes_add hS
    (realCommutes_mul (realCommutes_mul (realCommutes_mulI M) hS) (realCommutes_mulI M))

/-! ## Prop 18 — the R-complex commutant is `ℂ` -/

/-- **No antilinear commutant.**  The precise algebraic content of the C-complex
type: no nonzero `ℂ`-antilinear continuous operator commutes with `M`.  (An
anti-unitary is a nonzero commuting antilinear operator, so this implies
`IsCComplex`; see `noAntilinearCommutant_isCComplex`.) -/
def NoAntilinearCommutant (M : System ℂ V) : Prop :=
  ∀ T : V →L[ℝ] V,
    (∀ x, T (Complex.I • x) = -(Complex.I • T x)) → RealCommutes M T → T = 0

/-- `NoAntilinearCommutant` implies C-complex: an anti-unitary commuting with `M`
would be a nonzero commuting antilinear operator. -/
lemma noAntilinearCommutant_isCComplex {M : System ℂ V} [Nontrivial V]
    (h : NoAntilinearCommutant M) : IsCComplex M := by
  rintro ⟨θ, hθc⟩
  have hanti : ∀ x, thetaR θ (Complex.I • x) = -(Complex.I • thetaR θ x) := by
    intro x
    simp only [thetaR_apply]
    rw [θ.map_smulₛₗ]
    simp
  have h0 : thetaR θ = 0 := h (thetaR θ) hanti (realCommutes_thetaR hθc)
  obtain ⟨x, hx⟩ := exists_ne (0 : V)
  apply hx
  apply θ.injective
  have : thetaR θ x = 0 := by rw [h0]; rfl
  simpa using this

/-- **Prop 18 (R-complex commutant `≅ ℂ`).**  For a complex Schur system `(M, V)`
with no antilinear commutant, the real commutant is exactly the complex scalars:
an `ℝ`-linear operator commutes with `M` iff it is `cembed c` for some `c : ℂ`
(i.e. multiplication by a complex scalar).  Hence the real commutant `≅ ℂ`. -/
theorem Rcomplex_realCommutant_eq_complex (M : System ℂ V) (hSchur : IsSchurFull M)
    (hNo : NoAntilinearCommutant M) (S : V →L[ℝ] V) :
    RealCommutes M S ↔ ∃ c : ℂ, S = cembed c := by
  constructor
  · intro hS
    have hP := Plin_commutes_mulI S
    obtain ⟨c, hc⟩ := hSchur _ (cplxify_commutes hP (Plin_realCommutes hS))
    have hQ0 : Qanti S = 0 :=
      hNo (Qanti S) (Qanti_anticommutes_mulI S) (Qanti_realCommutes hS)
    have hSP : S = Plin S := by
      conv_lhs => rw [← Plin_add_Qanti S]
      rw [hQ0, add_zero]
    refine ⟨c, ?_⟩
    ext x
    rw [hSP, cembed_apply]
    have hcx : cplxify (Plin S) hP x = (c • (1 : V →L[ℂ] V)) x := by rw [hc]
    simpa using hcx
  · rintro ⟨c, rfl⟩
    exact cembed_realCommutes M c

/-! ## Prop 19 — the R-pseudoreal commutant is `ℍ` -/

/-- **Prop 19 (R-pseudoreal commutant `≅ ℍ`).**  For a complex Schur system
`(M, V)` with a commuting anti-unitary `θ` satisfying `θ² = -1`, the real
commutant is exactly the image of `qembed`: an `ℝ`-linear operator commutes with
`M` iff it is `qembed θ hθ q` for some quaternion `q`.  Together with
`qembed_injective` this exhibits the real commutant as `≅ ℍ`.

The `ℂ`-linear part `Plin S` is a complex scalar by `IsSchurFull`; the
`ℂ`-antilinear part `Qanti S` becomes complex-linear after composing with `θ`,
hence is a complex scalar multiple of `θ` — so `S = c·1 + d·θ`, which is
`qembed` of the quaternion `⟨c.re, c.im, d.re, d.im⟩`. -/
theorem Rpseudoreal_realCommutant_eq_quaternion (M : System ℂ V) (hSchur : IsSchurFull M)
    {θ : AntiUnitary V} (hθ : ∀ x, θ (θ x) = -x) (hθc : CommutesAntiUnitary M θ)
    (S : V →L[ℝ] V) :
    RealCommutes M S ↔ ∃ q : Quaternion ℝ, S = qembed θ hθ q := by
  have key : ∀ (a : ℂ) (v : V), a • v = a.re • v + a.im • (Complex.I • v) := by
    intro a v
    rw [← Complex.coe_smul, ← Complex.coe_smul, smul_smul, ← add_smul, Complex.re_add_im]
  constructor
  · intro hS
    -- Complex-linear part `Plin S` is a complex scalar `c`.
    have hP := Plin_commutes_mulI S
    obtain ⟨c, hc⟩ := hSchur _ (cplxify_commutes hP (Plin_realCommutes hS))
    have hPeq : ∀ x, Plin S x = c • x := by
      intro x
      have hx : cplxify (Plin S) hP x = (c • (1 : V →L[ℂ] V)) x := by rw [hc]
      simpa using hx
    -- `W := Qanti S ∘ θ` is complex-linear (antilinear ∘ antilinear).
    have hQanti := Qanti_anticommutes_mulI S
    have hWlin : ∀ x, (Qanti S * thetaR θ) (Complex.I • x)
        = Complex.I • (Qanti S * thetaR θ) x := by
      intro x
      simp only [ContinuousLinearMap.mul_apply, thetaR_apply]
      have hθI : θ (Complex.I • x) = -(Complex.I • θ x) := by
        rw [θ.map_smulₛₗ]; simp
      rw [hθI, map_neg, hQanti (θ x), neg_neg]
    have hWc : RealCommutes M (Qanti S * thetaR θ) :=
      realCommutes_mul (Qanti_realCommutes hS) (realCommutes_thetaR hθc)
    obtain ⟨d', hd'⟩ := hSchur _ (cplxify_commutes hWlin hWc)
    have hWeq : ∀ x, Qanti S (θ x) = d' • x := by
      intro x
      have hx : cplxify (Qanti S * thetaR θ) hWlin x = (d' • (1 : V →L[ℂ] V)) x := by
        rw [hd']
      simpa [ContinuousLinearMap.mul_apply, thetaR_apply] using hx
    -- Hence `Qanti S y = (-d') • θ y`.
    have hQeq : ∀ y, Qanti S y = (-d') • θ y := by
      intro y
      have hsym : θ (θ.symm y) = y := θ.apply_symm_apply y
      have hy : θ.symm y = -θ y := by
        apply θ.injective
        rw [hsym, map_neg, hθ, neg_neg]
      have hz := hWeq (θ.symm y)
      rw [hsym] at hz
      rw [hz, hy, smul_neg, neg_smul]
    -- Assemble `S = c·1 + (-d')·θ = qembed ⟨c.re, c.im, (-d').re, (-d').im⟩`.
    refine ⟨⟨c.re, c.im, (-d').re, (-d').im⟩, ?_⟩
    ext x
    have hSx : S x = c • x + (-d') • θ x := by
      have h1 : S x = Plin S x + Qanti S x := by
        conv_lhs => rw [← Plin_add_Qanti S]
        simp [ContinuousLinearMap.add_apply]
      rw [h1, hPeq x, hQeq x]
    rw [hSx]
    simp only [qembed_apply, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
      Algebra.algebraMap_eq_smul_one, ContinuousLinearMap.one_apply, mulI_apply,
      ContinuousLinearMap.mul_apply, thetaR_apply]
    rw [key c x, key (-d') (θ x)]
    abel
  · rintro ⟨q, rfl⟩
    exact qembed_realCommutes hθ hθc q

end BookProof.ChapterA
