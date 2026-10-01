-- Generated from ChapterYangMillsAbelianEsa.lean — theorem BookProof.YangMillsAbelianEsa.gramWeyl_eq
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
open BookProof.YangMillsAbelianEsa



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.YangMillsAbelianEsa.gramWeyl_eq {d N : ℕ} (v : Fin N → Fin d → ℝ)
    (T : Fin d → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) :
    ∑ i : Fin d, ∑ j : Fin d,
        ((((1 / 2 : ℝ) * ∑ m : Fin N, v m i * v m j : ℝ)) : ℂ) • weylProd (T i) (T j) p
      = ((1 / 2 : ℝ) : ℂ) • ∑ m : Fin N,
          (∑ i : Fin d, ((v m i : ℝ) : ℂ) • T i) ((∑ i : Fin d, ((v m i : ℝ) : ℂ) • T i) p) := by sorry
