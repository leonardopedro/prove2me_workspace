-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.hasCompactSupport_Lfun
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_hasCompactSupport_lapCS
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) (W : Vd d → ℝ) {g : Vd d → ℂ}
    (hgc : HasCompactSupport g) : HasCompactSupport (Lfun S W g) := (hasCompactSupport_lapCS S hgc).neg.add hgc.mul_left
