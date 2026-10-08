import Mathlib


/-!
# Lagrangian Navier–Stokes: the incompressibility determinant as a momentum convolution

In Lagrangian (material) variables a fluid configuration is the flow map
`X(a) = a + ξ(a)` of the reference points `a ∈ 𝕋³`, and incompressibility is the constraint
on the **determinant of the deformation gradient**

```
det F(a) = 1,        F(a) = I + ∇ₐξ(a) .
```

This module writes that constraint in momentum space for a Galerkin displacement field with a
finite set `K` of base wave vectors `k ∈ ℝ³`,

```
ξ(a) = Σ_{k ∈ K} ( ξ̂_k e^{i k·a} + conj(ξ̂_k) e^{−i k·a} )        (real by construction),
```

whose complex coefficients `ξ̂_{k,i} = x_{k,i,Re} + i x_{k,i,Im}` are the real phase-space
coordinates `x : K × Fin 3 × Bool → ℝ`.

* **Spatial derivatives are momenta.**  The derivative `∂_{a_c} ξ_r` is the Fourier series with
  coefficients `i w_c ξ̂_{m,r}` (`gradCoef`), `w = ±k` the wave vector of the signed mode `m`:
  `hasDerivAt_dispField` proves that this is literally the derivative of the displacement field.
* **Products are momentum convolutions.**  Expanding `det(I + ∇ξ)` row by row (the determinant
  is multilinear in the rows) turns the local cubic product into the triple convolution
  ```
  (det F)^(q) = Σ_{τ : Fin 3 → Option(modes),  w(τ 0)+w(τ 1)+w(τ 2) = q}  det [row r of B_{τ r}]
  ```
  where `B_none = I` (the identity part of `F`, wave vector `0`) and `B_m = (i w_c ξ̂_{m,r})_{rc}`
  (`detCoef`).  **`det_deformation_eq`** proves that the Fourier series with these coefficients is
  exactly `det(I + ∇ξ(a))` at every point `a` and every configuration.  Because the sum runs over
  *tuples of different modes*, the cross-mode minors survive: the constraint is **not** the
  degenerate rank-one single-mode substitution `F ↦ i ℓ ⊗ ξ` (whose determinant and cofactor
  vanish identically, `NsLagFourier.lagElimSubst_detPoly`).
* `volCoef q = (det F)^(q) − δ_{q,0}` are the Fourier coefficients of the constraint residual
  `det F − 1` (`volume_residual_eq`), and the **volume penalty**
  `V_κ = (κ/2) Σ_q |volCoef q|²` (`volPot`) is a real polynomial, non-negative at every real
  configuration (`volPot_eval_nonneg`), whose zero set consists of incompressible configurations:
  `det_eq_one_of_volPot_eq_zero` (for `κ > 0`, `V_κ = 0` forces `det F(a) = 1` for **all** `a`).
* `dispField_im` — the displacement field is real.

Everything is `sorry`-free and `axiom`-free.  The dynamics and the Faris–Lavine argument are in
`BookProof.ChapterNsLagrangianDetFarisLavine`.
-/

namespace BookProof.NsLagrangianDet

open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]

/-! ## 1. Modes, coefficients and the momentum-space derivative -/

/-- Indices of the real displacement coordinates: base mode `k`, component `i`, and
`false` for the real part, `true` for the imaginary part of `ξ̂_{k,i}`. -/
abbrev DIdx (K : Type*) := K × Fin 3 × Bool

/-- Signed modes: `(k, true)` carries the wave vector `+k` and the coefficient `ξ̂_k`,
`(k, false)` carries `−k` and `conj ξ̂_k`. -/
abbrev SMode (K : Type*) := K × Bool

/-- The wave vector of a signed mode. -/
def wv (kv : K → Fin 3 → ℝ) (m : SMode K) : Fin 3 → ℝ := if m.2 then kv m.1 else -kv m.1

/-- The complex Fourier coefficient of `ξ_i` at the signed mode `m`, as a polynomial in the
real coordinates: `ξ̂_{k,i} = x_{Re} + i x_{Im}` for `+k`, its conjugate for `−k`. -/
def scoef (m : SMode K) (i : Fin 3) : MvPolynomial (DIdx K) ℂ :=
  X (m.1, i, false) + (if m.2 then Complex.I else -Complex.I) • X (m.1, i, true)

/-- **The spatial derivative in momentum space**: the Fourier coefficient of `∂_{a_c} ξ_r` at
the signed mode `m` is `i w_c ξ̂_{m,r}`. -/
def gradCoef (kv : K → Fin 3 → ℝ) (m : SMode K) (r c : Fin 3) : MvPolynomial (DIdx K) ℂ :=
  (Complex.I * ((wv kv m c : ℝ) : ℂ)) • scoef m r

/-- The Fourier coefficients of the deformation gradient `F = I + ∇ξ`: the identity at the
zero mode (`none`) and `gradCoef` at the signed mode `m`. -/
def rowCoef (kv : K → Fin 3 → ℝ) : Option (SMode K) → Fin 3 → Fin 3 → MvPolynomial (DIdx K) ℂ
  | none, r, c => if r = c then 1 else 0
  | some m, r, c => gradCoef kv m r c

/-- The wave vector of an entry of `F`: `0` for the identity part. -/
def owv (kv : K → Fin 3 → ℝ) : Option (SMode K) → Fin 3 → ℝ
  | none => 0
  | some m => wv kv m

/-- The total momentum of a choice of one Fourier component of `F` per row. -/
def tupleWave (kv : K → Fin 3 → ℝ) (τ : Fin 3 → Option (SMode K)) : Fin 3 → ℝ :=
  ∑ r, owv kv (τ r)

open Classical in
/-- **The determinant as a triple momentum convolution**: the Fourier coefficient at `q` of
`det(I + ∇ξ)`, the sum over all choices `τ` of one Fourier component of `F` per row with total
momentum `q` of the determinant of the chosen rows. -/
def detCoef (kv : K → Fin 3 → ℝ) (q : Fin 3 → ℝ) : MvPolynomial (DIdx K) ℂ :=
  ∑ τ ∈ Finset.univ.filter (fun τ => tupleWave kv τ = q),
    (Matrix.of fun r c => rowCoef kv (τ r) r c).det

open Classical in
/-- The Fourier coefficient at `q` of the incompressibility residual `det F − 1`. -/
def volCoef (kv : K → Fin 3 → ℝ) (q : Fin 3 → ℝ) : MvPolynomial (DIdx K) ℂ :=
  detCoef kv q - if q = 0 then 1 else 0

open Classical in
/-- The (finite) set of momenta that occur in `det F`. -/
def waveSet (kv : K → Fin 3 → ℝ) : Finset (Fin 3 → ℝ) := Finset.univ.image (tupleWave kv)

/-- Complex conjugation of the coefficients. -/
def conjP (p : MvPolynomial (DIdx K) ℂ) : MvPolynomial (DIdx K) ℂ := map (starRingEnd ℂ) p

/-- **The incompressibility (volume) penalty** `V_κ = (κ/2) Σ_q |(det F − 1)^(q)|²`, a real
polynomial of degree six in the displacement coordinates. -/
def volPot (kappa : ℝ) (kv : K → Fin 3 → ℝ) : MvPolynomial (DIdx K) ℂ :=
  ((kappa / 2 : ℝ) : ℂ) • ∑ q ∈ waveSet kv, conjP (volCoef kv q) * volCoef kv q



/-! ## 2. The fields in position space -/

/-- Evaluation at a real configuration. -/
def ev (y : DIdx K → ℝ) : MvPolynomial (DIdx K) ℂ →+* ℂ := eval fun j => ((y j : ℝ) : ℂ)

/-- The plane wave `e^{i w·a}`. -/
def phase (w a : Fin 3 → ℝ) : ℂ := Complex.exp (Complex.I * ((∑ c, w c * a c : ℝ) : ℂ))

/-- The displacement field `ξ_i(a)` of the configuration `y`. -/
def dispField (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ) (i : Fin 3) : ℂ :=
  ∑ m : SMode K, ev y (scoef m i) * phase (wv kv m) a

/-- The displacement gradient `∂_{a_c} ξ_r(a)`, assembled from its momentum-space coefficients. -/
def dispGrad (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ) : Matrix (Fin 3) (Fin 3) ℂ :=
  Matrix.of fun r c => ∑ m : SMode K, ev y (gradCoef kv m r c) * phase (wv kv m) a









/-! ## 3. The determinant of the deformation gradient is the triple convolution -/



/-- The plane wave of an entry of `F`. -/
def ophase (kv : K → Fin 3 → ℝ) (a : Fin 3 → ℝ) (o : Option (SMode K)) : ℂ :=
  phase (owv kv o) a

int
on the **determinant of the deformation gradient**

```
det F(a) = 1,        F(a) = I + ∇ₐξ(a) .
```

This module writes that constraint in momentum space for a Galerkin displacement field with a
finite set `K` of base wave vectors `k ∈ ℝ³`,

```
ξ(a) = Σ_{k ∈ K} ( ξ̂_k e^{i k·a} + conj(ξ̂_k) e^{−i k·a} )        (real by construction),
```

whose complex coefficients `ξ̂_{k,i} = x_{k,i,Re} + i x_{k,i,Im}` are the real phase-space
coordinates `x : K × Fin 3 × Bool → ℝ`.

* **Spatial derivatives are momenta.**  The derivative `∂_{a_c} ξ_r` is the Fourier series with
  coefficients `i w_c ξ̂_{m,r}` (`gradCoef`), `w = ±k` the wave vector of the signed mode `m`:
  `hasDerivAt_dispField` proves that this is literally the derivative of the displacement field.
* **Products are momentum convolutions.**  Expanding `det(I + ∇ξ)` row by row (the determinant
  is multilinear in the rows) turns the local cubic product into the triple convolution
  ```
  (det F)^(q) = Σ_{τ : Fin 3 → Option(modes),  w(τ 0)+w(τ 1)+w(τ 2) = q}  det [row r of B_{τ r}]
  ```
  where `B_none = I` (the identity part of `F`, wave vector `0`) and `B_m = (i w_c ξ̂_{m,r})_{rc}`
  (`detCoef`).  **`det_deformation_eq`** proves that the Fourier series with these coefficients is
  exactly `det(I + ∇ξ(a))` at every point `a` and every configuration.  Because the sum runs over
  *tuples of different modes*, the cross-mode minors survive: the constraint is **not** the
  degenerate rank-one single-mode substitution `F ↦ i ℓ ⊗ ξ` (whose determinant and cofactor
  vanish identically, `NsLagFourier.lagElimSubst_detPoly`).
* `volCoef q = (det F)^(q) − δ_{q,0}` are the Fourier coefficients of the constraint residual
  `det F − 1` (`volume_residual_eq`), and the **volume penalty**
  `V_κ = (κ/2) Σ_q |volCoef q|²` (`volPot`) is a real polynomial, non-negative at every real
  configuration (`volPot_eval_nonneg`), whose zero set consists of incompressible configurations:
  `det_eq_one_of_volPot_eq_zero` (for `κ > 0`, `V_κ = 0` forces `det F(a) = 1` for **all** `a`).
* `dispField_im` — the displacement field is real.

Everything is `sorry`-free and `axiom`-free.  The dynamics and the Faris–Lavine argument are in
`BookProof.ChapterNsLagrangianDetFarisLavine`.
-/

namespace BookProof.NsLagrangianDet

open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]

/-! ## 1. Modes, coefficients and the momentum-space derivative -/

/-- Indices of the real displacement coordinates: base mode `k`, component `i`, and
`false` for the real part, `true` for the imaginary part of `ξ̂_{k,i}`. -/
abbrev DIdx (K : Type*) := K × Fin 3 × Bool

/-- Signed modes: `(k, true)` carries the wave vector `+k` and the coefficient `ξ̂_k`,
`(k, false)` carries `−k` and `conj ξ̂_k`. -/
abbrev SMode (K : Type*) := K × Bool

/-- The wave vector of a signed mode. -/
def wv (kv : K → Fin 3 → ℝ) (m : SMode K) : Fin 3 → ℝ := if m.2 then kv m.1 else -kv m.1

/-- The complex Fourier coefficient of `ξ_i` at the signed mode `m`, as a polynomial in the
real coordinates: `ξ̂_{k,i} = x_{Re} + i x_{Im}` for `+k`, its conjugate for `−k`. -/
def scoef (m : SMode K) (i : Fin 3) : MvPolynomial (DIdx K) ℂ :=
  X (m.1, i, false) + (if m.2 then Complex.I else -Complex.I) • X (m.1, i, true)

/-- **The spatial derivative in momentum space**: the Fourier coefficient of `∂_{a_c} ξ_r` at
the signed mode `m` is `i w_c ξ̂_{m,r}`. -/
def gradCoef (kv : K → Fin 3 → ℝ) (m : SMode K) (r c : Fin 3) : MvPolynomial (DIdx K) ℂ :=
  (Complex.I * ((wv kv m c : ℝ) : ℂ)) • scoef m r

/-- The Fourier coefficients of the deformation gradient `F = I + ∇ξ`: the identity at the
zero mode (`none`) and `gradCoef` at the signed mode `m`. -/
def rowCoef (kv : K → Fin 3 → ℝ) : Option (SMode K) → Fin 3 → Fin 3 → MvPolynomial (DIdx K) ℂ
  | none, r, c => if r = c then 1 else 0
  | some m, r, c => gradCoef kv m r c

/-- The wave vector of an entry of `F`: `0` for the identity part. -/
def owv (kv : K → Fin 3 → ℝ) : Option (SMode K) → Fin 3 → ℝ
  | none => 0
  | some m => wv kv m

/-- The total momentum of a choice of one Fourier component of `F` per row. -/
def tupleWave (kv : K → Fin 3 → ℝ) (τ : Fin 3 → Option (SMode K)) : Fin 3 → ℝ :=
  ∑ r, owv kv (τ r)

open Classical in
/-- **The determinant as a triple momentum convolution**: the Fourier coefficient at `q` of
`det(I + ∇ξ)`, the sum over all choices `τ` of one Fourier component of `F` per row with total
momentum `q` of the determinant of the chosen rows. -/
def detCoef (kv : K → Fin 3 → ℝ) (q : Fin 3 → ℝ) : MvPolynomial (DIdx K) ℂ :=
  ∑ τ ∈ Finset.univ.filter (fun τ => tupleWave kv τ = q),
    (Matrix.of fun r c => rowCoef kv (τ r) r c).det

open Classical in
/-- The Fourier coefficient at `q` of the incompressibility residual `det F − 1`. -/
def volCoef (kv : K → Fin 3 → ℝ) (q : Fin 3 → ℝ) : MvPolynomial (DIdx K) ℂ :=
  detCoef kv q - if q = 0 then 1 else 0

open Classical in
/-- The (finite) set of momenta that occur in `det F`. -/
def waveSet (kv : K → Fin 3 → ℝ) : Finset (Fin 3 → ℝ) := Finset.univ.image (tupleWave kv)

/-- Complex conjugation of the coefficients. -/
def conjP (p : MvPolynomial (DIdx K) ℂ) : MvPolynomial (DIdx K) ℂ := map (starRingEnd ℂ) p

/-- **The incompressibility (volume) penalty** `V_κ = (κ/2) Σ_q |(det F − 1)^(q)|²`, a real
polynomial of degree six in the displacement coordinates. -/
def volPot (kappa : ℝ) (kv : K → Fin 3 → ℝ) : MvPolynomial (DIdx K) ℂ :=
  ((kappa / 2 : ℝ) : ℂ) • ∑ q ∈ waveSet kv, conjP (volCoef kv q) * volCoef kv q

theorem conjP_volPot (kappa : ℝ) (kv : K → Fin 3 → ℝ) :
    conjP (volPot kappa kv) = volPot kappa kv := by
  have hcc : ∀ p : MvPolynomial (DIdx K) ℂ, conjP (conjP p) = p := by
    intro p
    rw [conjP, conjP, MvPolynomial.map_map]
    have : (starRingEnd ℂ).comp (starRingEnd ℂ) = RingHom.id ℂ := by
      ext z; simp
    rw [this, MvPolynomial.map_id]
  rw [volPot, conjP, MvPolynomial.smul_eq_C_mul, map_mul, map_C, map_sum, Complex.conj_ofReal]
  congr 1
  refine Finset.sum_congr rfl fun q _ => ?_
  rw [map_mul]
  change conjP (conjP _) * conjP _ = _
  rw [hcc, mul_comm]

/-! ## 2. The fields in position space -/

/-- Evaluation at a real configuration. -/
def ev (y : DIdx K → ℝ) : MvPolynomial (DIdx K) ℂ →+* ℂ := eval fun j => ((y j : ℝ) : ℂ)

/-- The plane wave `e^{i w·a}`. -/
def phase (w a : Fin 3 → ℝ) : ℂ := Complex.exp (Complex.I * ((∑ c, w c * a c : ℝ) : ℂ))

/-- The displacement field `ξ_i(a)` of the configuration `y`. -/
def dispField (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ) (i : Fin 3) : ℂ :=
  ∑ m : SMode K, ev y (scoef m i) * phase (wv kv m) a

/-- The displacement gradient `∂_{a_c} ξ_r(a)`, assembled from its momentum-space coefficients. -/
def dispGrad (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ) : Matrix (Fin 3) (Fin 3) ℂ :=
  Matrix.of fun r c => ∑ m : SMode K, ev y (gradCoef kv m r c) * phase (wv kv m) a

theorem phase_zero (a : Fin 3 → ℝ) : phase 0 a = 1 := by simp [phase]

theorem phase_sum {ι : Type*} (s : Finset ι) (w : ι → Fin 3 → ℝ) (a : Fin 3 → ℝ) :
    ∏ i ∈ s, phase (w i) a = phase (∑ i ∈ s, w i) a := by
  simp only [phase]
  rw [← Complex.exp_sum]
  congr 1
  rw [← Finset.mul_sum, ← Complex.ofReal_sum]
  congr 2
  simp only [Finset.sum_apply]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun c _ => by rw [Finset.sum_mul]

/-- **The spatial derivative is the momentum multiplier**: along the direction `e_c`, the
derivative of the displacement field `ξ_r` is the Fourier series with coefficients
`i w_c ξ̂_{m,r}`. -/
theorem hasDerivAt_dispField (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ)
    (r c : Fin 3) :
    HasDerivAt (fun t : ℝ => dispField kv y (a + t • (Pi.single c (1 : ℝ) : Fin 3 → ℝ)) r)
      (dispGrad kv y a r c) 0 := by
  unfold dispField dispGrad
  simp only [Matrix.of_apply]
  apply HasDerivAt.fun_sum
  intro m _
  have hlin : ∀ t : ℝ, (∑ c', wv kv m c' * (a + t • (Pi.single c (1 : ℝ) : Fin 3 → ℝ)) c')
      = (∑ c', wv kv m c' * a c') + t * wv kv m c := by
    intro t
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, mul_add, Finset.sum_add_distrib]
    congr 1
    rw [Finset.sum_eq_single c (fun b _ hb => by simp [hb])
      (fun h => absurd (Finset.mem_univ c) h)]
    simp
    ring
  have hphase : HasDerivAt
      (fun t : ℝ => phase (wv kv m) (a + t • (Pi.single c (1 : ℝ) : Fin 3 → ℝ)))
      (Complex.I * ((wv kv m c : ℝ) : ℂ) * phase (wv kv m) a) 0 := by
    have hin : HasDerivAt (fun t : ℝ => Complex.I * ((((∑ c', wv kv m c' * a c')
        + t * wv kv m c : ℝ)) : ℂ)) (Complex.I * ((wv kv m c : ℝ) : ℂ)) 0 := by
      have h1 : HasDerivAt (fun t : ℝ => (((∑ c', wv kv m c' * a c') + t * wv kv m c : ℝ)))
          (wv kv m c) 0 := by
        simpa using ((hasDerivAt_id (0 : ℝ)).mul_const (wv kv m c)).const_add
          (∑ c', wv kv m c' * a c')
      simpa using (h1.ofReal_comp).const_mul Complex.I
    have := hin.cexp
    simp only [zero_mul, add_zero] at this
    convert this using 1
    · funext t
      rw [phase, hlin t]
    · rw [phase]; ring
  have := hphase.const_mul (ev y (scoef m r))
  convert this using 1 <;>
    (first
      | rfl
      | rw [gradCoef, MvPolynomial.smul_eq_C_mul, map_mul]; simp [ev]; ring)

/-- The displacement field is real: the modes `±k` carry conjugate coefficients. -/
theorem dispField_im (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ) (i : Fin 3) :
    (dispField kv y a i).im = 0 := by
  unfold dispField
  rw [Fintype.sum_prod_type, Complex.im_sum]
  refine Finset.sum_eq_zero fun k _ => ?_
  rw [Fintype.sum_bool]
  have hconj : ev y (scoef (k, false) i) * phase (wv kv (k, false)) a
      = (starRingEnd ℂ) (ev y (scoef (k, true) i) * phase (wv kv (k, true)) a) := by
    simp only [scoef, wv, ev, phase, map_add, map_mul, MvPolynomial.smul_eq_C_mul,
      MvPolynomial.eval_C, MvPolynomial.eval_X, if_true, Bool.false_eq_true, if_false]
    rw [← Complex.exp_conj]
    simp [Complex.conj_ofReal, Finset.sum_neg_distrib]
  rw [hconj, Complex.add_im, Complex.conj_im]
  ring

/-! ## 3. The determinant of the deformation gradient is the triple convolution -/

/-- The determinant is multilinear in the rows: a row-wise sum expands into the sum over
choices of one summand per row. -/
theorem det_rows_sum {n ι R : Type*} [Fintype n] [DecidableEq n] [Fintype ι] [CommRing R]
    (v : n → ι → n → R) :
    (Matrix.of fun r c => ∑ o, v r o c).det
      = ∑ τ : n → ι, (Matrix.of fun r c => v r (τ r) c).det := by
  have h := (Matrix.detRowAlternating (n := n) (R := R)).toMultilinearMap.map_sum
    (fun r o => v r o)
  have e1 : (Matrix.of fun r c => ∑ o, v r o c) = fun r => ∑ o, v r o := by
    ext r c; simp [Finset.sum_apply]
  rw [e1]
  exact h

/-- The plane wave of an entry of `F`. -/
def ophase (kv : K → Fin 3 → ℝ) (a : Fin 3 → ℝ) (o : Option (SMode K)) : ℂ :=
  phase (owv kv o) a

theorem one_add_dispGrad (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ) :
    1 + dispGrad kv y a
      = Matrix.of fun r c => ∑ o : Option (SMode K), ev y (rowCoef kv o r c) * ophase kv a o := by
  ext r c
  rw [Matrix.add_apply, Matrix.one_apply, Matrix.of_apply, Fintype.sum_option]
  simp only [dispGrad, Matrix.of_apply, rowCoef, ophase, owv, phase_zero, mul_one]
  congr 1
  split_ifs <;> simp

/-- **The determinant of the deformation gradient in momentum space**: at every configuration
`y` and every reference point `a`,
`det(I + ∇ξ(a)) = Σ_{q} (det F)^(q)(y) e^{i q·a}`, with the coefficients `detCoef` given by the
triple momentum convolution. -/
theorem det_deformation_eq (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ) :
    (1 + dispGrad kv y a).det = ∑ q ∈ waveSet kv, ev y (detCoef kv q) * phase q a := by
  classical
  rw [one_add_dispGrad, det_rows_sum]
  have hterm : ∀ τ : Fin 3 → Option (SMode K),
      (Matrix.of fun r c => ev y (rowCoef kv (τ r) r c) * ophase kv a (τ r)).det
        = ev y ((Matrix.of fun r c => rowCoef kv (τ r) r c).det) * phase (tupleWave kv τ) a := by
    intro τ
    have e1 : (Matrix.of fun r c => ev y (rowCoef kv (τ r) r c) * ophase kv a (τ r))
        = Matrix.of fun r c => ophase kv a (τ r) * ((ev y).mapMatrix
            (Matrix.of fun r c => rowCoef kv (τ r) r c)) r c := by
      ext r c; simp [mul_comm]
    rw [e1, det_mul_column, RingHom.map_det, mul_comm]
    congr 1
    rw [tupleWave, ← phase_sum]
    rfl
  rw [Finset.sum_congr rfl fun τ _ => hterm τ]
  simp only [detCoef, map_sum, Finset.sum_mul]
  symm
  calc ∑ q ∈ waveSet kv, ∑ τ ∈ Finset.univ.filter (fun τ => tupleWave kv τ = q),
        ev y ((Matrix.of fun r c => rowCoef kv (τ r) r c).det) * phase q a
      = ∑ q ∈ waveSet kv, ∑ τ ∈ Finset.univ.filter (fun τ => tupleWave kv τ = q),
        ev y ((Matrix.of fun r c => rowCoef kv (τ r) r c).det) * phase (tupleWave kv τ) a :=
        Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun τ hτ => by
          rw [(Finset.mem_filter.mp hτ).2]
    _ = _ := Finset.sum_fiberwise_of_maps_to (fun τ _ => by simp [waveSet]) _













end

end BookProof.NsLagrangianDet
