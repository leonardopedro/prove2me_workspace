import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Mathlib
import Theorems.Thm_BookProof_HermiteRelative_momPoly_eq_ymMomOp
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreEquiv_coe
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Theorems.Thm_BookProof_FullQuadratic_fqOp_essentiallySelfAdjoint
import Theorems.Thm_BookProof_FullQuadratic_fqOp_symmetric
import Theorems.Thm_BookProof_FullQuadratic_fqOp_stone_flow
import Theorems.Thm_BookProof_QuadFockEsa_dGamma_fqPoly_essentiallySelfAdjointOn_core


/-!
# The mainstream Navier–Stokes Koopman generator, linear part: essential self-adjointness
(NS mainstream leg, redesigned)

`BookProof.ChapterNsKoopman` defines the mainstream (Koopman–von Neumann) Navier–Stokes
Hamiltonian `H_NS = ½ Σ_m (π_m F_m + F_m π_m)`, `F = −νΛu + B(u,u)`, on the Gauss–polynomial
core, and `NsKoopman.nsKoopman_esa_of_energy_comparison` derived its essential
self-adjointness from a Faris–Lavine comparison with the Leray energy `N_E = 1 + ‖u‖²`,
**under** the hypothesis `hsurj` that `N_E + 1` maps the core onto `L²`.  That hypothesis is
false (`NsEnergySurjectivityObstruction.not_nsEnergy_surjective`), and — informally — no
multiplication operator dominates the first-order generator, so the Leray-energy route
cannot be repaired by a change of domain alone.

This module is the redesign of the leg in the part where it can be closed with the tools of
the project: **the generator of every affine drift is a real quadratic Hamiltonian**, so its
essential self-adjointness is an instance of the Carleman-flux theorem
`FullQuadratic.fqOp_essentiallySelfAdjoint`, with no comparison operator, no surjectivity and
no sign hypothesis.  This covers

* the **Stokes** system (no advection) — `nsKoopmanOp S` itself, for every mainstream system
  `S` whose advection vanishes (`nsKoopman_stokes_esa`);
* the **Oseen linearization** of the full Navier–Stokes drift about an *arbitrary* point `ū`
  (steady or not), `F(ū) + DF(ū)(u − ū)` with `DF(ū)_{ij} = −νλ_iδ_{ij} + Σ_k (b_{ijk} +
  b_{ikj}) ū_k` (`oseenKoopman_esa`);
* every **affine** drift `F(u) = A u + c` with real `A`, `c` (`linKoopman_esa`), with its
  Stone flow and its second quantization `dΓ` on the finite-occupation core.

## What is proved

* `linDrift A c i = Σ_j A_{ij} u_j + c_i`, `linKvnPoly A c = Σ_i ½(π_i F_i + F_i π_i)` — the
  Weyl-ordered generator of an affine drift;
* **`linKvnPoly_eq_fqPoly`** — it *is* the general quadratic Hamiltonian
  `fqPoly 0 0 Aᵀ 0 c` (no kinetic and no potential part: only the Weyl-ordered cross terms
  `½(u_jπ_i + π_iu_j)` and the momenta);
* `linKoopmanOp A c` (on the core) and **`linKoopman_esa`**, `linKoopman_stone_flow`,
  `linKoopman_dGammaOp_esa`;
* `drift_eq_linDrift_of_stokes`, **`nsKoopman_stokes_esa`** — for a mainstream system with
  vanishing advection the mainstream operator `nsKoopmanOp S` of `ChapterNsKoopman` is
  essentially self-adjoint;
* `oseenMat`, `oseenConst`, `oseenDrift_eq` (the affine drift is the first-order Taylor
  polynomial of the mainstream drift at `ū`: `drift S` and `linDrift` agree up to the
  quadratic remainder `B(u − ū, u − ū)`), **`oseenKoopman_esa`**.

## Honest boundary

* The **nonlinear** mainstream generator (advection `B ≠ 0`) is not covered: it is cubic, its
  Hermite matrix grows like `deg^{3/2}`, and neither the graded-band Schur gate nor the
  quadratic Carleman flux applies.  The route recorded for it is completeness of the classical
  flow (the energy inequality makes the Navier–Stokes Galerkin flow global in both time
  directions, and `div F = −ν Σ λ_i` is constant): the orbit criterion
  `FlowDGammaEsa.deficiencyTrivialAt_of_orbits` then needs a core invariant under the flow,
  i.e. the smooth dependence of the flow on its initial data, which Mathlib does not provide.
* The Oseen operator is the Koopman generator of the *linearized* flow, not a perturbation
  bound for the nonlinear one.
* No gap, spectrum, uniqueness or global-existence statement is made.
-/

namespace BookProof.NsLinearKoopmanEsa

open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.NsKoopman
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

variable {d : ℕ}

/-! ## 1. The generator of an affine drift -/

/-- The affine drift `F_i(u) = Σ_j A_{ij} u_j + c_i`. -/
def linDrift (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) (i : Fin d) : MvPolynomial (Fin d) ℂ :=
  ∑ j, ((A i j : ℝ) : ℂ) • X j + C ((c i : ℝ) : ℂ)

/-- The Weyl-ordered Koopman–von Neumann generator `½ Σ_i (π_i F_i + F_i π_i)` of the affine
drift (the same formula as `NsKoopman.kvnPoly`). -/
def linKvnPoly (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) : Module.End ℂ (MvPolynomial (Fin d) ℂ) :=
  ∑ i, weylProd (momOp i) (mulOp (linDrift A c i))

theorem weylProd_add_right' (S T T' : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    weylProd S (T + T') = weylProd S T + weylProd S T' := by
  simp only [weylProd, LinearMap.comp_add, LinearMap.add_comp, smul_add]
  abel

theorem weylProd_smul_right' (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) (a : ℂ) :
    weylProd S (a • T) = a • weylProd S T := by
  simp only [weylProd, LinearMap.comp_smul, LinearMap.smul_comp, smul_add, smul_comm a]

theorem weylProd_sum_right' {ι : Type*} (s : Finset ι) (S : Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (T : ι → Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    weylProd S (∑ j ∈ s, T j) = ∑ j ∈ s, weylProd S (T j) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
      simp [weylProd]
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, weylProd_add_right', ih]

theorem weylProd_comm' (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    weylProd S T = weylProd T S := by
  simp only [weylProd, add_comm]

theorem mulOp_add' (f g : MvPolynomial (Fin d) ℂ) : mulOp (f + g) = mulOp f + mulOp g := by
  refine LinearMap.ext fun p => ?_
  simp [add_mul]

theorem mulOp_smul' (a : ℂ) (f : MvPolynomial (Fin d) ℂ) : mulOp (a • f) = a • mulOp f := by
  refine LinearMap.ext fun p => ?_
  simp

theorem mulOp_sum' {ι : Type*} (s : Finset ι) (f : ι → MvPolynomial (Fin d) ℂ) :
    mulOp (∑ j ∈ s, f j) = ∑ j ∈ s, mulOp (f j) := by
  refine LinearMap.ext fun p => ?_
  simp [Finset.sum_mul, LinearMap.sum_apply]

theorem mulOp_C' (a : ℂ) : mulOp (C a : MvPolynomial (Fin d) ℂ) = a • LinearMap.id := by
  refine LinearMap.ext fun p => ?_
  simp [MvPolynomial.smul_eq_C_mul]

theorem weylProd_id' (S : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    weylProd S LinearMap.id = S := by
  simp only [weylProd, LinearMap.comp_id, LinearMap.id_comp]
  rw [← two_smul ℂ S, smul_smul]
  norm_num

/-- **The affine-drift generator is a real quadratic Hamiltonian**: `fqPoly 0 0 Aᵀ 0 c`. -/
theorem linKvnPoly_eq_fqPoly (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    linKvnPoly A c = fqPoly 0 0 (fun j i => A i j) 0 c := by
  have hterm : ∀ i : Fin d, weylProd (momOp i) (mulOp (linDrift A c i))
      = (∑ j, ((A i j : ℝ) : ℂ) • weylProd (mulXPoly j) (momPoly i))
        + ((c i : ℝ) : ℂ) • momPoly i := by
    intro i
    rw [linDrift, mulOp_add', mulOp_sum', weylProd_add_right', weylProd_sum_right', mulOp_C',
      weylProd_smul_right', weylProd_id', momPoly_eq_ymMomOp]
    congr 1
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [mulOp_smul', weylProd_smul_right', weylProd_comm', mulXPoly_eq_mulOp]
  rw [linKvnPoly, Finset.sum_congr rfl fun i _ => hterm i, Finset.sum_add_distrib, fqPoly,
    fqQuadPoly, foPoly]
  simp only [Pi.zero_apply, Complex.ofReal_zero, zero_smul, zero_add]
  rw [Finset.sum_comm]

/-- The affine-drift generator on the Gauss–polynomial core. -/
def linKoopmanOp (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype.comp ((coreRepPoly d).op (linKvnPoly A c))

theorem coreRepPoly_equiv' (p : MvPolynomial (Fin d) ℂ) :
    (coreRepPoly d).equiv p = coreEquiv p := by
  refine Subtype.ext ?_
  rw [(coreRepPoly d).coe_equiv p, coreEquiv_coe p]

/-- An operator given through `coreRepPoly` is the same as the one given through `coreOp`. -/
theorem subtype_comp_coreRepPoly_op (T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    (polyGaussCore (d := d)).subtype.comp ((coreRepPoly d).op T)
      = (polyGaussCore (d := d)).subtype ∘ₗ coreOp T := by
  refine LinearMap.ext fun x => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := d)).surjective x
  have hx : ((coreRepPoly d).equiv.symm (coreEquiv p) : MvPolynomial (Fin d) ℂ) = p := by
    rw [← coreRepPoly_equiv' p, LinearEquiv.symm_apply_apply]
  rw [LinearMap.comp_apply, Submodule.subtype_apply, CoreRep.coe_op, hx, LinearMap.comp_apply,
    Submodule.subtype_apply, coreOp_coe]

theorem linKoopmanOp_eq_fqOp (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    linKoopmanOp A c = fqOp 0 0 (fun j i => A i j) 0 c := by
  rw [linKoopmanOp, subtype_comp_coreRepPoly_op, linKvnPoly_eq_fqPoly, fqOp]

/-- **ESA of the Koopman generator of every affine drift.** -/
theorem linKoopman_esa (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (linKoopmanOp A c) := by
  rw [linKoopmanOp_eq_fqOp]
  exact fqOp_essentiallySelfAdjoint _ _ _ _ _

theorem linKoopman_symmetricOn (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (linKoopmanOp A c) := by
  rw [linKoopmanOp_eq_fqOp]
  exact fqOp_symmetric _ _ _ _ _

/-- The unitary Koopman group of an affine drift (Stone). -/
theorem linKoopman_stone_flow (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (linKoopmanOp A c) T.op ∧ IsStoneFlow T U := by
  rw [linKoopmanOp_eq_fqOp]
  exact fqOp_stone_flow _ _ _ _ _

/-- The second quantization of the affine-drift generator, in the occupation-number spelling,
is essentially self-adjoint on the finite-occupation core. -/
theorem linKoopman_dGammaOp_esa (e : ℕ ≃ (Fin d →₀ ℕ)) (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (BookProof.NavierStokesFlow.lpFiniteModes Conf)
      (dGammaOp (hermCol e (linKvnPoly A c))) := by
  rw [linKvnPoly_eq_fqPoly]
  exact dGamma_fqPoly_essentiallySelfAdjointOn_core e _ _ _ _ _

/-! ## 2. The Stokes system: the mainstream operator itself -/

/-- The Stokes matrix `−ν λ_i δ_{ij}`. -/
def stokesMat (S : NsSystem d) (i j : Fin d) : ℝ := if i = j then -(S.nu * S.lam i) else 0

/-- With no advection the mainstream drift is the affine drift of the Stokes matrix. -/
theorem drift_eq_linDrift_of_stokes (S : NsSystem d) (hB : S.bcoef = 0) (i : Fin d) :
    drift S i = linDrift (stokesMat S) 0 i := by
  classical
  simp only [drift, linDrift, advOf, hB, stokesMat, Pi.zero_apply, Complex.ofReal_zero,
    zero_smul, Finset.sum_const_zero, add_zero, map_zero]
  rw [Finset.sum_eq_single i]
  · simp
  · intro j _ hj
    simp [Ne.symm hj]
  · simp

/-- **The mainstream Navier–Stokes operator of a Stokes system is essentially self-adjoint.**
For every mainstream system with vanishing advection, `nsKoopmanOp S` — the operator of
`ChapterNsKoopman`, unchanged — is essentially self-adjoint on the Gauss–polynomial core. -/
theorem nsKoopman_stokes_esa (S : NsSystem d) (hB : S.bcoef = 0) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (nsKoopmanOp S) := by
  have h : kvnPoly S = linKvnPoly (stokesMat S) 0 := by
    rw [kvnPoly, linKvnPoly]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [drift_eq_linDrift_of_stokes S hB i]
  have h2 : nsKoopmanOp S = linKoopmanOp (stokesMat S) 0 := by
    rw [nsKoopmanOp, linKoopmanOp, h]
  rw [h2]
  exact linKoopman_esa _ _

/-! ## 3. The Oseen linearization about an arbitrary point -/

/-- The Jacobian of the mainstream drift at `ū`:
`DF(ū)_{ij} = −ν λ_i δ_{ij} + Σ_k (b_{ijk} + b_{ikj}) ū_k`. -/
def oseenMat (S : NsSystem d) (ubar : Fin d → ℝ) (i j : Fin d) : ℝ :=
  stokesMat S i j + ∑ k, (S.bcoef i j k + S.bcoef i k j) * ubar k

/-- The constant of the first-order Taylor polynomial: `F(ū) − DF(ū) ū = −B(ū, ū)`. -/
def oseenConst (S : NsSystem d) (ubar : Fin d → ℝ) (i : Fin d) : ℝ :=
  -(∑ j, ∑ k, S.bcoef i j k * ubar j * ubar k)

/-- The mainstream drift at a real point. -/
def driftAt (S : NsSystem d) (u : Fin d → ℝ) (i : Fin d) : ℝ :=
  -(S.nu * S.lam i) * u i + ∑ j, ∑ k, S.bcoef i j k * u j * u k

/-- The affine drift evaluated at a real point. -/
def linDriftAt (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) (u : Fin d → ℝ) (i : Fin d) : ℝ :=
  ∑ j, A i j * u j + c i

/-- **The Oseen drift is the first-order Taylor polynomial of the mainstream drift at `ū`**:
the two differ exactly by the quadratic remainder `B(u − ū, u − ū)`. -/
theorem oseenDrift_eq (S : NsSystem d) (ubar u : Fin d → ℝ) (i : Fin d) :
    driftAt S u i
      = linDriftAt (oseenMat S ubar) (oseenConst S ubar) u i
        + ∑ j, ∑ k, S.bcoef i j k * (u j - ubar j) * (u k - ubar k) := by
  classical
  simp only [driftAt, linDriftAt, oseenMat, oseenConst, stokesMat]
  have hs : ∑ j, (if i = j then -(S.nu * S.lam i) else 0) * u j = -(S.nu * S.lam i) * u i := by
    rw [Finset.sum_eq_single i]
    · simp
    · intro j _ hj; simp [Ne.symm hj]
    · simp
  simp only [add_mul, Finset.sum_add_distrib, hs, Finset.sum_mul]
  have h1 : ∀ j k : Fin d, S.bcoef i j k * (u j - ubar j) * (u k - ubar k)
      = S.bcoef i j k * u j * u k - S.bcoef i j k * ubar k * u j
        - S.bcoef i j k * ubar j * u k + S.bcoef i j k * ubar j * ubar k := fun j k => by ring
  simp only [h1, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  have h2 : ∑ j, ∑ k, S.bcoef i j k * ubar j * u k = ∑ j, ∑ k, S.bcoef i k j * ubar k * u j := by
    rw [Finset.sum_comm]
  rw [h2]
  ring

/-- **ESA of the Oseen Koopman generator.**  For every mainstream system `S` and every point
`ū`, the Koopman generator of the linearized Navier–Stokes flow at `ū` is essentially
self-adjoint on the Gauss–polynomial core. -/
theorem oseenKoopman_esa (S : NsSystem d) (ubar : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (linKoopmanOp (oseenMat S ubar) (oseenConst S ubar)) :=
  linKoopman_esa _ _

/-- The unitary Koopman group of the Oseen linearization (Stone). -/
theorem oseenKoopman_stone_flow (S : NsSystem d) (ubar : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (linKoopmanOp (oseenMat S ubar) (oseenConst S ubar)) T.op ∧
        IsStoneFlow T U :=
  linKoopman_stone_flow _ _

end

end BookProof.NsLinearKoopmanEsa
