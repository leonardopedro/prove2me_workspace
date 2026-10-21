-- Generated from ChapterSmHamiltonian.lean — solution of BookProof.SmHamiltonian.RealCoeff.sub'
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Theorems.Thm_BookProof_YangMillsHermite_starP_sub
open BookProof.SmHamiltonian




open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} {p q : MvPolynomial (Fin d) ℂ} (hp : RealCoeff p)
    (hq : RealCoeff q) : RealCoeff (p - q) := by

  change starP (p - q) = p - q
  rw [starP_sub, show starP p = p from hp, show starP q = q from hq]
