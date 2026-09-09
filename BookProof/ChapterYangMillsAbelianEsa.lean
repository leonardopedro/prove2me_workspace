import Mathlib
import BookProof.ChapterYangMillsHermite
import BookProof.ChapterFullQuadraticEsa

/-!
# Essential self-adjointness of the **abelian** gauge-fixed Yang–Mills Hamiltonian on the
Gauss–polynomial core of `L²(ℝ⁹⁹)`

`BookProof.ChapterYangMillsHermite` builds the field-space Weyl-gauge Yang–Mills
Hamiltonian

`H₁ = ½ Σ_m π_m² + ½ Σ_m B_m²`,  `B_{i a} = ε_{ijk}(∂_j A_{k,a} + f_{abc} A_{j,b} A_{k,c})`,

on the Gauss–polynomial core of `L²(ℝ⁹⁹)` and proves it symmetric and positive there, so
that the Friedrichs machinery applies (`ym_hermite_friedrichs_extension`).  What it does
*not* give is **uniqueness** of the self-adjoint realization.

This module supplies it in the **abelian** case `f_{abc} = 0` — the numerics' "abelian
gapless limit" operator.  There the magnetic field
`B_{i a} = ε_{ijk} ∂_j A_{k,a}` is a *linear* form in the coordinates, so `H₁` is a genuine
real quadratic Hamiltonian in the canonical pair, and the Carleman instrument
`BookProof.FullQuadratic.fqOp_essentiallySelfAdjoint` — the engine behind
`BookProof.Qg3DGaugeEsa.qg3D_essentiallySelfAdjointOn_core` — applies verbatim.  What is
needed is only an **identification**: the abelian Yang–Mills Hamiltonian *is* one of those
quadratic Hamiltonians, for an explicit pair of real coefficient matrices.

## What is proved

* `gramWeyl_eq` — the reusable algebraic step: for coefficient vectors `v_m` the
  Weyl-ordered Gram combination `Σ_{i,j} (½ Σ_m v_{m i} v_{m j}) ·½(T_iT_j + T_jT_i)`
  is `½ Σ_m S_m²` with `S_m = Σ_i v_{m i} T_i`.
* `ymMomVec`, `ymMagVec`, `ymFqP`, `ymFqQ` — the coefficient data: the `24` momenta
  `π_m = −i ∂/∂A_{j,a}` pick out `24` of the `99` coordinates, and the abelian magnetic
  field is the linear form `Σ_n (ymMagVec m n)·x_n`.
* `sum_ymMomVec_mom`, `sum_ymMagVec_X` — the two identities behind that.
* `ymAbelianPoly_eq_fqPoly` — the operator identity at polynomial level:
  `½ Σ_m π_m² + ½ Σ_m B_m² = fqPoly ymFqP ymFqQ 0 0 0`.
* `ymAbelian_eq_fqOp` — the same identity on the core of `L²(ℝ⁹⁹)`.
* `ymAbelian_essentiallySelfAdjointOn_core` — **the headline**: the abelian gauge-fixed
  Yang–Mills Hamiltonian `ymHamiltonian (coreRepPoly 99) 0` is essentially self-adjoint on
  the Gauss–polynomial core, so its closure is the unique self-adjoint realization — and in
  particular *is* the Friedrichs extension of `ym_hermite_friedrichs_extension`.
* `ymAbelian_positiveExtension_eq_closure` — consequently the Friedrichs extension *is* the
  closure: in the abelian case the selection problem is empty.
* `ymAbelian_hashimoto_selects` — the Hashimoto/SIRK shift-invert algorithm selects that
  unique realization, at any family of non-real shifts.
* `ymAbelian_stone_flow` — the complete unitary group it generates (Stone).

## Honest boundary

This is the **abelian** (`f_{abc} = 0`) one-particle operator only.  For `g ≠ 0` the term
`B²` is quartic in the coordinates and neither this quadratic instrument nor the
Faris–Lavine sums-of-squares machinery covers it; that remains open.  No mass gap, no
spectrum and no continuum limit is claimed here; the Fock lift is the separate `dΓ` layer.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.YangMillsAbelianEsa

open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

/-! ## 1. A reusable Gram identity for Weyl-ordered squares -/

theorem weylProd_self_apply {d : ℕ} (S : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) : weylProd S S p = S (S p) := by
  simp only [weylProd, LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply]
  rw [← two_smul ℂ (S (S p)), smul_smul]
  norm_num

theorem triple_swap' {α : Type*} [AddCommMonoid α] {N D : ℕ} (F : Fin N → Fin D → Fin D → α) :
    ∑ i : Fin D, ∑ j : Fin D, ∑ m : Fin N, F m i j
      = ∑ m : Fin N, ∑ i : Fin D, ∑ j : Fin D, F m i j := by
  calc ∑ i : Fin D, ∑ j : Fin D, ∑ m : Fin N, F m i j
      = ∑ i : Fin D, ∑ m : Fin N, ∑ j : Fin D, F m i j :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ m : Fin N, ∑ i : Fin D, ∑ j : Fin D, F m i j := Finset.sum_comm

/-- **The Gram identity.**  For any family of operators `T_i` and coefficient vectors `v_m`,
the Weyl-ordered quadratic form of the Gram matrix `½ Σ_m v_m v_mᵀ` is the sum of squares
`½ Σ_m S_m²` of the linear combinations `S_m = Σ_i v_{m i} T_i`. -/
theorem gramWeyl_eq {d N : ℕ} (v : Fin N → Fin d → ℝ)
    (T : Fin d → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) :
    ∑ i : Fin d, ∑ j : Fin d,
        ((((1 / 2 : ℝ) * ∑ m : Fin N, v m i * v m j : ℝ)) : ℂ) • weylProd (T i) (T j) p
      = ((1 / 2 : ℝ) : ℂ) • ∑ m : Fin N,
          (∑ i : Fin d, ((v m i : ℝ) : ℂ) • T i) ((∑ i : Fin d, ((v m i : ℝ) : ℂ) • T i) p) := by
  have hL : ∑ i : Fin d, ∑ j : Fin d,
        ((((1 / 2 : ℝ) * ∑ m : Fin N, v m i * v m j : ℝ)) : ℂ) • weylProd (T i) (T j) p
      = ∑ i : Fin d, ∑ j : Fin d, ∑ m : Fin N,
          (((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ))
            • weylProd (T i) (T j) p := by
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    have hc : ((((1 / 2 : ℝ) * ∑ m : Fin N, v m i * v m j : ℝ)) : ℂ)
        = ∑ m : Fin N, (((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) := by
      push_cast
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun m _ => by ring
    rw [hc, Finset.sum_smul]
  rw [hL, triple_swap', Finset.smul_sum]
  refine Finset.sum_congr rfl fun m _ => ?_
  -- the Weyl symmetrization is absorbed by the symmetry of the coefficients
  have hexp : (∑ i : Fin d, ((v m i : ℝ) : ℂ) • T i)
        ((∑ i : Fin d, ((v m i : ℝ) : ℂ) • T i) p)
      = ∑ i : Fin d, ∑ j : Fin d,
          (((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • T i (T j p) := by
    simp only [LinearMap.sum_apply, LinearMap.smul_apply, map_sum, map_smul, Finset.smul_sum,
      smul_smul]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [mul_comm]
  have hweyl : ∀ i j : Fin d,
      (((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • weylProd (T i) (T j) p
        = ((1 / 2 : ℝ) : ℂ)
            • ((((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • T i (T j p))
          + ((1 / 2 : ℝ) : ℂ)
            • ((((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • T j (T i p)) := by
    intro i j
    simp only [weylProd, LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply,
      smul_add, smul_smul]
    congr 1 <;> (congr 1; push_cast; ring)
  have hA : ∑ i : Fin d, ∑ j : Fin d,
        (((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • weylProd (T i) (T j) p
      = ((1 / 2 : ℝ) : ℂ) • ((∑ i : Fin d, ∑ j : Fin d,
            (((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • T i (T j p))
          + ∑ i : Fin d, ∑ j : Fin d,
            (((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • T j (T i p)) := by
    rw [smul_add, Finset.smul_sum, Finset.smul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.smul_sum, Finset.smul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun j _ => hweyl i j
  have hswap : ∑ i : Fin d, ∑ j : Fin d,
        (((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • T j (T i p)
      = ∑ i : Fin d, ∑ j : Fin d,
        (((1 / 2 : ℝ) : ℂ) * ((v m i : ℝ) : ℂ) * ((v m j : ℝ) : ℂ)) • T i (T j p) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    congr 1
    ring
  rw [hA, hswap, hexp]
  congr 1
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← add_smul]
  congr 1
  push_cast
  ring

/-! ## 2. The coefficient data of the abelian Yang–Mills Hamiltonian -/

/-- The coordinate index of the field `A_{j,a}` carried by the `m`-th of the `24`
field/colour pairs — the coordinate the `m`-th momentum differentiates. -/
def ymMomIdx (m : Fin 24) : Fin 99 := idxA (decodeSpace m) (decodeColor m)

theorem ymMomIdx_val (m : Fin 24) : (ymMomIdx m).val = 3 + m.val := by
  simp only [ymMomIdx, idxA, decodeSpace, decodeColor]
  omega

/-- The coefficient vector of the `m`-th momentum: the unit vector at `ymMomIdx m`. -/
def ymMomVec (m : Fin 24) (n : Fin 99) : ℝ := if n = ymMomIdx m then 1 else 0

/-- The coefficient vector of the `m`-th **abelian** magnetic field
`B_{i a} = ε_{ijk} ∂_j A_{k,a}`, a linear form in the `99` coordinates. -/
def ymMagVec (m : Fin 24) (n : Fin 99) : ℝ :=
  ∑ j : Fin 3, ∑ k : Fin 3,
    (if n = idxD j k (decodeColor m) then levi (decodeSpace m) j k else 0)

/-- The momentum matrix of the abelian Yang–Mills Hamiltonian. -/
def ymFqP (i j : Fin 99) : ℝ := (1 / 2) * ∑ m : Fin 24, ymMomVec m i * ymMomVec m j

/-- The coordinate matrix of the abelian Yang–Mills Hamiltonian: the Gram matrix of the
magnetic coefficient vectors. -/
def ymFqQ (i j : Fin 99) : ℝ := (1 / 2) * ∑ m : Fin 24, ymMagVec m i * ymMagVec m j

theorem sum_ymMomVec_mom (m : Fin 24) :
    ∑ n : Fin 99, ((ymMomVec m n : ℝ) : ℂ) • momPoly (d := 99) n
      = momPoly (ymMomIdx m) := by
  rw [Finset.sum_eq_single (ymMomIdx m)]
  · simp [ymMomVec]
  · intro b _ hb
    simp [ymMomVec, hb]
  · intro h
    exact absurd (Finset.mem_univ (ymMomIdx m)) h

/-- **The abelian magnetic field is a linear form** with coefficient vector `ymMagVec`. -/
theorem sum_ymMagVec_X (m : Fin 24) :
    ∑ n : Fin 99, ((ymMagVec m n : ℝ) : ℂ) • (X n : MvPolynomial (Fin 99) ℂ)
      = magPoly 0 (decodeSpace m) (decodeColor m) := by
  have hmag : magPoly 0 (decodeSpace m) (decodeColor m)
      = ∑ j : Fin 3, ∑ k : Fin 3, ((levi (decodeSpace m) j k : ℝ) : ℂ)
          • (X (idxD j k (decodeColor m)) : MvPolynomial (Fin 99) ℂ) := by
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
    simp
  have hL : ∑ n : Fin 99, ((ymMagVec m n : ℝ) : ℂ) • (X n : MvPolynomial (Fin 99) ℂ)
      = ∑ n : Fin 99, ∑ j : Fin 3, ∑ k : Fin 3,
          ((if n = idxD j k (decodeColor m) then (levi (decodeSpace m) j k : ℝ) else 0 : ℝ) : ℂ)
            • (X n : MvPolynomial (Fin 99) ℂ) := by
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [ymMagVec]
    push_cast
    rw [Finset.sum_smul]
    exact Finset.sum_congr rfl fun j _ => Finset.sum_smul
  rw [hL, hmag]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.sum_eq_single (idxD j k (decodeColor m))]
  · simp
  · intro b _ hb
    simp [hb]
  · intro h
    exact absurd (Finset.mem_univ (idxD j k (decodeColor m))) h

theorem sum_ymMagVec_mulX (m : Fin 24) :
    ∑ n : Fin 99, ((ymMagVec m n : ℝ) : ℂ) • mulXPoly (d := 99) n
      = mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) := by
  refine LinearMap.ext fun p => ?_
  simp only [LinearMap.sum_apply, LinearMap.smul_apply, mulXPoly_apply, mulOp_apply]
  rw [← sum_ymMagVec_X m, Finset.sum_mul]
  exact Finset.sum_congr rfl fun n _ => by rw [smul_mul_assoc]

/-! ## 3. The identification with the general quadratic Hamiltonian -/

/-- The polynomial-level abelian Yang–Mills Hamiltonian `½ Σ_m π_m² + ½ Σ_m B_m²`. -/
def ymAbelianPoly : MvPolynomial (Fin 99) ℂ →ₗ[ℂ] MvPolynomial (Fin 99) ℂ :=
  ((1 / 2 : ℝ) : ℂ) •
    ((∑ m : Fin 24, (YangMillsHermite.momOp (ymMomIdx m)).comp
        (YangMillsHermite.momOp (ymMomIdx m)))
      + ∑ m : Fin 24, (mulOp (magPoly 0 (decodeSpace m) (decodeColor m))).comp
          (mulOp (magPoly 0 (decodeSpace m) (decodeColor m))))

theorem ymAbelianPoly_apply (p : MvPolynomial (Fin 99) ℂ) :
    ymAbelianPoly p
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ m : Fin 24,
              YangMillsHermite.momOp (ymMomIdx m) (YangMillsHermite.momOp (ymMomIdx m) p))
            + ∑ m : Fin 24, mulOp (magPoly 0 (decodeSpace m) (decodeColor m))
                (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) p)) := by
  simp [ymAbelianPoly]

set_option maxHeartbeats 2000000 in
-- the 99×99 double sums over the Weyl-ordered pairs make this identification expensive
set_option maxRecDepth 20000 in
/-- **The identification at polynomial level.**  The abelian Yang–Mills Hamiltonian is the
general real quadratic Hamiltonian with momentum matrix `ymFqP`, coordinate matrix `ymFqQ`,
no cross term and no first-order term. -/
theorem ymAbelianPoly_eq_fqPoly : ymAbelianPoly = fqPoly ymFqP ymFqQ 0 0 0 := by
  refine LinearMap.ext fun p => ?_
  have hfo : foPoly (d := 99) 0 0 p = 0 := by simp [foPoly]
  have hmom : ∑ i : Fin 99, ∑ j : Fin 99,
      ((ymFqP i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p
        = ((1 / 2 : ℝ) : ℂ) • ∑ m : Fin 24,
            YangMillsHermite.momOp (ymMomIdx m) (YangMillsHermite.momOp (ymMomIdx m) p) := by
    have hstep : ∑ i : Fin 99, ∑ j : Fin 99,
        ((ymFqP i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p
          = ∑ i : Fin 99, ∑ j : Fin 99,
            ((((1 / 2 : ℝ) * ∑ m : Fin 24, ymMomVec m i * ymMomVec m j : ℝ)) : ℂ)
              • weylProd ((fun i => momPoly i) i) ((fun i => momPoly i) j) p :=
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [ymFqP]
    rw [hstep, gramWeyl_eq ymMomVec (fun i => momPoly i) p]
    refine congrArg (fun z => ((1 / 2 : ℝ) : ℂ) • z) ?_
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [sum_ymMomVec_mom m, momPoly_eq_ymMomOp]
  have hmul : ∑ i : Fin 99, ∑ j : Fin 99,
      ((ymFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
        = ((1 / 2 : ℝ) : ℂ) • ∑ m : Fin 24,
            mulOp (magPoly 0 (decodeSpace m) (decodeColor m))
              (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) p) := by
    have hstep : ∑ i : Fin 99, ∑ j : Fin 99,
        ((ymFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
          = ∑ i : Fin 99, ∑ j : Fin 99,
            ((((1 / 2 : ℝ) * ∑ m : Fin 24, ymMagVec m i * ymMagVec m j : ℝ)) : ℂ)
              • weylProd ((fun i => mulXPoly i) i) ((fun i => mulXPoly i) j) p :=
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [ymFqQ]
    rw [hstep, gramWeyl_eq ymMagVec (fun i => mulXPoly i) p]
    refine congrArg (fun z => ((1 / 2 : ℝ) : ℂ) • z) ?_
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [sum_ymMagVec_mulX m]
  have hfq : fqPoly ymFqP ymFqQ 0 0 0 p
      = (∑ i : Fin 99, ∑ j : Fin 99,
          ((ymFqP i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p)
        + ∑ i : Fin 99, ∑ j : Fin 99,
            ((ymFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p := by
    rw [fqPoly, fqQuadPoly]
    simp only [LinearMap.add_apply, LinearMap.sum_apply, LinearMap.smul_apply, Pi.zero_apply,
      Complex.ofReal_zero, zero_smul, add_zero, hfo]
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_add_distrib
  rw [ymAbelianPoly_apply, hfq, hmom, hmul, smul_add]

/-! ## 4. Transport to the core of `L²(ℝ⁹⁹)` -/

theorem coreRepPoly_equiv (p : MvPolynomial (Fin 99) ℂ) :
    (coreRepPoly 99).equiv p = coreEquiv p := by
  refine Subtype.ext ?_
  rw [(coreRepPoly 99).coe_equiv p, coreEquiv_coe p]

theorem pgLp_eq_pgMap (p : MvPolynomial (Fin 99) ℂ) : pgLp p = pgMap (d := 99) p := rfl

theorem pgLp_ymAbelianPoly (p : MvPolynomial (Fin 99) ℂ) :
    pgLp (ymAbelianPoly p)
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ m : Fin 24, pgLp (YangMillsHermite.momOp (ymMomIdx m)
              (YangMillsHermite.momOp (ymMomIdx m) p)))
            + ∑ m : Fin 24, pgLp (mulOp (magPoly 0 (decodeSpace m) (decodeColor m))
                (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) p))) := by
  rw [ymAbelianPoly_apply]
  simp only [pgLp_eq_pgMap, map_smul, map_add, map_sum]

set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core make these defeq checks expensive
set_option maxRecDepth 8000 in
/-- **The identification on the core.**  The abelian field-space Yang–Mills Hamiltonian on
the Gauss–polynomial core is the general quadratic Hamiltonian `fqOp ymFqP ymFqQ 0 0 0`. -/
theorem ymAbelian_eq_fqOp :
    ymHamiltonian (coreRepPoly 99) 0 = fqOp ymFqP ymFqQ 0 0 0 := by
  refine LinearMap.ext fun x => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := 99)).surjective x
  have hx : ((coreRepPoly 99).equiv.symm (coreEquiv p) : MvPolynomial (Fin 99) ℂ) = p := by
    rw [← coreRepPoly_equiv p, LinearEquiv.symm_apply_apply]
  have hmom : ∀ m : Fin 24,
      ((piOps (coreRepPoly 99) m (piOps (coreRepPoly 99) m (coreEquiv p))
        : polyGaussCore (d := 99)) : L2d 99)
        = pgLp (YangMillsHermite.momOp (ymMomIdx m)
            (YangMillsHermite.momOp (ymMomIdx m) p)) := by
    intro m
    rw [piOps, CoreRep.coe_op, CoreRep.op_apply, LinearEquiv.symm_apply_apply, hx]
    rfl
  have hmag : ∀ m : Fin 24,
      ((magOps (coreRepPoly 99) 0 m (magOps (coreRepPoly 99) 0 m (coreEquiv p))
        : polyGaussCore (d := 99)) : L2d 99)
        = pgLp (mulOp (magPoly 0 (decodeSpace m) (decodeColor m))
            (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) p)) := by
    intro m
    rw [magOps, CoreRep.coe_op, CoreRep.op_apply, LinearEquiv.symm_apply_apply, hx]
  rw [ymHamiltonian, YangMillsFriedrichs.weylOp_apply]
  simp only [hmom, hmag]
  rw [fqOp, LinearMap.comp_apply, Submodule.subtype_apply, coreOp_coe,
    ← ymAbelianPoly_eq_fqPoly, pgLp_ymAbelianPoly]

/-! ## 5. Essential self-adjointness -/

/-- **The headline.**  The abelian (`f_{abc} = 0`) gauge-fixed Yang–Mills Hamiltonian
`H₁ = ½ Σ_m π_m² + ½ Σ_m B_m²` of `BookProof.ChapterYangMillsHermite`, on the
Gauss–polynomial core of `L²(ℝ⁹⁹)`, is **essentially self-adjoint**: its closure is the
unique self-adjoint realization, and therefore coincides with the Friedrichs extension
supplied by `ym_hermite_friedrichs_extension`. -/
theorem ymAbelian_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (polyGaussCore (d := 99)) (ymHamiltonian (coreRepPoly 99) 0) := by
  rw [ymAbelian_eq_fqOp]
  exact fqOp_essentiallySelfAdjoint ymFqP ymFqQ 0 0 0

/-- **The Friedrichs extension of the abelian Yang–Mills Hamiltonian is its closure.**
Any positive self-adjoint extension — in particular the one produced by
`BookProof.YangMillsHermite.ym_hermite_friedrichs_extension` — has the domain of the closure
and agrees with the closure there: for `f_abc = 0` there is nothing to select. -/
theorem ymAbelian_positiveExtension_eq_closure {Dom : Submodule ℂ (L2d 99)}
    {A : Dom →ₗ[ℂ] L2d 99}
    (hA : IsPositiveSelfAdjointExtension (ymHamiltonian (coreRepPoly 99) 0) A) :
    Dom = clDom (ymHamiltonian (coreRepPoly 99) 0) ∧
      ∀ (x : L2d 99) (h : x ∈ Dom) (h' : x ∈ clDom (ymHamiltonian (coreRepPoly 99) 0)),
        A ⟨x, h⟩ = clExt (ymHamiltonian (coreRepPoly 99) 0) polyGaussCore_dense
          (ymHamiltonian_symmetricOn (coreRepPoly 99) 0) ⟨x, h'⟩ :=
  positiveExtension_eq_closure_of_esa polyGaussCore_dense
    (ymHamiltonian_symmetricOn (coreRepPoly 99) 0)
    ymAbelian_essentiallySelfAdjointOn_core hA

/-- **The Hashimoto/SIRK shift-invert algorithm selects the abelian Yang–Mills Hamiltonian.**
For `f_abc = 0` no positivity argument is needed: essential self-adjointness supplies the
unique self-adjoint realization, the shift-invert operators at any family of non-real shifts
are bounded, their ranges are exactly its domain, they satisfy the resolvent identity and
commute, and the Galerkin compressions converge strongly to them. -/
theorem ymAbelian_hashimoto_selects (b : HilbertBasis ℕ ℂ (L2d 99)) (γ : ℕ → ℂ)
    (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 99)) (A : Dom →ₗ[ℂ] L2d 99) (X : ℕ → L2d 99 →L[ℂ] L2d 99),
      IsSelfAdjointExtension (ymHamiltonian (coreRepPoly 99) 0) A ∧
      (∀ j, IsShiftInvertC A (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : L2d 99 →ₗ[ℂ] L2d 99))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ (L2d 99) - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Filter.Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) Filter.atTop
        (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (L2d 99)) (A' : Dom' →ₗ[ℂ] L2d 99),
        IsShiftInvertC A' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : L2d 99) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  hashimoto_multishift_selects_esa b _ polyGaussCore_dense
    (ymHamiltonian_symmetricOn (coreRepPoly 99) 0)
    ymAbelian_essentiallySelfAdjointOn_core γ hγ

/-- **The complete unitary flow of the abelian Yang–Mills Hamiltonian**, by Stone's theorem
applied to the unique self-adjoint extension supplied by essential self-adjointness. -/
theorem ymAbelian_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (L2d 99)) (U : ℝ → (L2d 99 →L[ℂ] L2d 99)),
      IsSelfAdjointExtension (ymHamiltonian (coreRepPoly 99) 0) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense
    (ymHamiltonian_symmetricOn (coreRepPoly 99) 0)
    ymAbelian_essentiallySelfAdjointOn_core

end

end BookProof.YangMillsAbelianEsa
