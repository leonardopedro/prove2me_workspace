-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsHamiltonian_isPolynomial
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.nsHamiltonian_isPolynomial :
    nsHamiltonian d = ∑ a : NSWordIndex, nsCoeff d.nu a • ((nsWord a).map (nsGen d)).prod := by sorry
