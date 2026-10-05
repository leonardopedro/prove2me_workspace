-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.hasCompactSupport_mol
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
open BookProof.DegKatoEsa




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : HasCompactSupport (mol d n) := (molBump d n).hasCompactSupport_normed
